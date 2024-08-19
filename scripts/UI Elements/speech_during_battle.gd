extends Control

@export_category("Speech Options")
@export_group("Dialogue")
@export var successful_parry: Array[String] = ["Haha!", "Almost got me!", "You ain't nothing!"]
@export var successful_attack: Array[String] = ["Take that!", "I'm the best!", "No match for me"]
@export var unsuccesful_parry: Array[String] = ["Ugh!", "Nooo!", "Hey! Stop!"]
@export var unsuccesful_attack: Array[String] = ["I'll get you next time!", "Oh no..."]
@export var passive_charged: Array[String] = ["I'm all powerful!", "Thank you for that"]
@export var opponent_attack: Array[String] = ["Get ready...", "Here I come..."]
@export var on_defeat: Array[String] = ["Noooo!", "MY TOY!"]
@export var on_victory: Array[String] = ["HAHA!", "YES!", "I'M THE BEST!"]
@export_group("Damage speech")
@export var no_damage: String = "I missed!"
@export var one_damage: String = "Punch!"
@export var two_damage: String = "Super Punch!"
@export var three_damage: String = "Hyper Punch!"
@export var four_damage: String = "Hyper Super Punch!"
@export var more_damage: String = "GAZZILLION DAMAGE!"
@export_group("Color")
@export var neutral: Color = Color.BLACK
@export var angry: Color = Color.DARK_RED
@export var sad: Color = Color.MEDIUM_BLUE

@onready var speech_label = $MarginContainer/Expression
var transitioning = false

func _ready():
	var rng = RandomNumberGenerator.new()
	await get_tree().create_timer(rng.randf_range(0.1, 0.5)).timeout
	show()
	_dissappear()

func _initialize(_option):
	var _text: String
	var _current_array: Array
	var rng = RandomNumberGenerator.new()
	speech_label = $MarginContainer/Expression
	match _option:
		0:
			_current_array = successful_parry
		1:
			_current_array = successful_attack
		2:
			_current_array = unsuccesful_parry
		3:
			_current_array = unsuccesful_attack
		4:
			_current_array = passive_charged
		5:
			_current_array = on_defeat
		6:
			_current_array = on_victory
	_text = _current_array[rng.randi_range(0, _current_array.size() - 1)]
	speech_label.text = _text

func _ready_to_attack():
	var rng = RandomNumberGenerator.new()
	var _text: String
	speech_label = $MarginContainer/Expression
	_text = opponent_attack[rng.randi_range(0, opponent_attack.size() - 1)]
	speech_label.text = _text

func _calling_damage(_dmg):
	var _text: String
	speech_label = $MarginContainer/Expression
	match _dmg:
		0:
			_text = no_damage
		1:
			_text = one_damage
		2:
			_text = two_damage
		3:
			_text = three_damage
		4:
			_text = four_damage
	if _text == null:
		_text = more_damage
	speech_label.text = _text

func _dissappear():
	if transitioning:
		return
	transitioning = true

	await get_tree().create_timer(2).timeout
	
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN)
	_tween.set_trans(Tween.TRANS_LINEAR)
	_tween.tween_property(self, "modulate", Color(Color.WHITE,0.0), 0.1).from(Color(Color.WHITE,1.0))
	
	await _tween.finished
	queue_free()
