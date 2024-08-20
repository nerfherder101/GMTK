extends Control

@onready var speech_label = $MarginContainer/Expression
var transitioning = false
var position_in_y
var position_in_x

func _ready():
	await get_tree().create_timer(0.2).timeout
	_appear()

func _initialize(_text):
	speech_label = $MarginContainer/Expression
	speech_label.text = _text


func _appear():
	position.y = position_in_y
	position.x = position_in_x
	position.y = position.y + 20
	show()
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN)
	_tween.set_trans(Tween.TRANS_LINEAR)
	_tween.set_parallel(true)
	_tween.tween_property(self, "modulate", Color(Color.WHITE,1), 0.25).from(Color(Color.WHITE,0.0))
	_tween.tween_property(self, "position", Vector2(position.x, position.y - 20), 0.25).from_current()
	await _tween.finished

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
