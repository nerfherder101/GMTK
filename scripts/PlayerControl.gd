extends Panel
class_name PlayerControl

@export var attack_button: Button = null

@export var data: PlayerData = null

@export var abilities: Array[Ability]


func _ready() -> void:
	#connect buttons
	attack_button.pressed.connect(attack)
	

	#var i = 0
	#for ab in abilities:
	#	buttons[i].connect("pressed", Callable(ab, "trigger_ability").bind(get_parent().enemy.body, get_parent().player_body))
	#	buttons[i].pressed.connect(self.on_select)
	#	buttons[i].text = ab.name
	#	i += 1

func attack():
	self.visible = false

	var timing_mg = get_parent().timing_minigame
	timing_mg.start_game(10, 100)	
	
	await timing_mg.timing_game_ended
	var success = timing_mg.get_success()
	var dmg = data.atk
	if success:
		dmg += 1
	
	get_parent().enemy.do_damage(dmg)
	# insert animation here
	await get_tree().create_timer(2).timeout
	
	on_select()
	

func toggle_selection() -> void: 
	self.visible = true

func on_select() -> void:
	get_parent().player_turn_end()
