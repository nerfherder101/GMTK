extends Panel
class_name PlayerControl

@export var attack_button: TextureButton = null
@export var parry_button: TextureButton = null
@export var data: PlayerData = null

@export var abilities: Array[Ability]
@export var battle_screen: Control

@onready var parrying: bool = false
@onready var parry_selected: bool = false
@onready var hbox_container = $HBoxContainer


#AUDIO
@onready var sfx_hover = %SFX_Hover
@onready var sfx_accept = %SFX_Accept
@onready var sfx_error = %SFX_Error

func _ready() -> void:
	#connect buttons
	attack_button.pressed.connect(attack)

func attack():
	hbox_container.visible = false

	var timing_mg = battle_screen.timing_minigame
	timing_mg.start_game(10, 100)	
	
	await timing_mg.timing_game_ended
	var success = timing_mg.get_success()
	var dmg = data.atk
	if success:
		dmg += 1
		_play_sfx(1)
		battle_screen._simple_speech(1, 0, true)
		battle_screen._simple_speech(2, 0, false)
		battle_screen._call_damage(dmg, 0)
	else:
		_play_sfx(2)
		battle_screen._simple_speech(3, 0, true)

	battle_screen.enemy.do_damage(dmg)
	# insert animation here
	await get_tree().create_timer(2).timeout
	
	on_select()

func toggle_selection() -> void:
	hbox_container.visible = true
	parry_button.hide()

func on_select() -> void:
	battle_screen.player_turn_end()

func _on_parry_pressed() -> void:
	if parry_selected:
		_play_sfx(2)
		return
	parry_button.disabled = true
	_play_sfx(1)
	parry_selected = true
	parrying = true
	battle_screen.player_body.modulate = Color(0.403, 1, 0.999)
	await get_tree().create_timer(0.6).timeout
	battle_screen.player_body.modulate = Color.WHITE
	parrying = false
	await get_tree().create_timer(0.35).timeout
	parry_selected = false
	parry_button.disabled = false

func _enter_defense(): #FUNCTION CALLED BY THE BATTLE CONTROLLER WHEN THE OPPONENT IS ATTACKING
	parry_button.show()
	pass

func _play_sfx(_index):
	match _index:
		0:
			sfx_hover.play()
		1:
			sfx_accept.play()
		2:
			sfx_error.play()


func _on_attack_mouse_entered() -> void:
	_play_sfx(0)


func _on_special_mouse_entered() -> void:
	_play_sfx(0)


func _on_parry_mouse_entered() -> void:
	_play_sfx(0)
