extends Panel
class_name PlayerControl

@export_category("Load Resources")
@export_group("Local Resources")
@export var attack_button: TextureButton = null
@export var parry_button: TextureButton = null
@export var data: PlayerData = null
@export var abilities: Array[Ability]
@export var battle_screen: Control
@export_category("General Info")
@export var crit_chance: float = 0.05 #playtest


@onready var parrying: bool = false
@onready var parry_selected: bool = false
@onready var hbox_container = $HBoxContainer


#AUDIO
@onready var sfx_hover = %SFX_Hover
@onready var sfx_accept = %SFX_Accept
@onready var sfx_error = %SFX_Error
@onready var sfx_success = %SFX_Success

func _ready() -> void:
	#connect buttons
	attack_button.pressed.connect(attack)

func attack():
	hbox_container.visible = false

	var timing_mg = battle_screen.timing_minigame
	timing_mg.start_game(10, 100)	
	
	await timing_mg.timing_game_ended
	var success = timing_mg.get_success()
	var base_crit = 1 #to multiply later
	var rng = RandomNumberGenerator.new()
	var _dice = snapped(rng.randf_range(0,1), 0.01)
	var dmg = data.atk + Global_Player_Information.character_attributes["strength"]
	if success:
		if crit_chance >= _dice:
			base_crit = 2
			battle_screen._simple_speech(7, 0, true) #speech bubble
		dmg *= base_crit #TO CONSIDER CRIT HITS WHEN THEY LAND 
		dmg += 1
		_play_sfx(3)
		#Three functions below are to call for speech bubbles, only aesthetic functions
		battle_screen._simple_speech(1, 0, true)
		battle_screen._simple_speech(2, 0, false)
		battle_screen._call_damage(dmg, 0) #BUBBLES
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
	_play_sfx(3)
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
		3:
			sfx_success.play()


func _on_attack_mouse_entered() -> void:
	_play_sfx(0)


func _on_special_mouse_entered() -> void:
	_play_sfx(0)


func _on_parry_mouse_entered() -> void:
	_play_sfx(0)
