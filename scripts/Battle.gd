extends Control
class_name Battle_Screen

@export_category("General Info")
@export var battle_id: int = 0
@export_category("Load Resources")
@export_group("Local Nodes")
@export var enemy: Enemy = null
@export var player_body: Body = null
@export var player_control: PlayerControl = null
@export var timing_minigame: TimingGame = null
@export var speech_bubble_player: MarginContainer
@export var speech_bubble_opponent: MarginContainer
@export var player_bar: MarginContainer
@export var player_passive_bar: ProgressBar
@export_group("UI")
@export var speech_bubble: Resource

@onready var audio_node = $Audio
@onready var music_i = %Music_InitialLoop
@onready var music_c = %Music_ContinuousLoop

#passive
@onready var passive_charges_total: int = -1
@onready var current_passive_charges: int = 0
@onready var enemy_is_stunned: bool = false
@onready var player_is_stunned: bool = false

@onready var black_panel = %Black_Panel
@onready var battle_has_ended: bool = false
#REWARDS
@onready var body_selector = %BodyPartSelector
@onready var head_r = %Head
@onready var torso_r = %Torso
@onready var arms_r = %Arms
@onready var legs_r = %Legs

@onready var l_one = %"1"
@onready var l_two = %"2"
@onready var l_three = %"3"
@onready var l_four = %"4"

func _ready() -> void:
	_fade_in()
	player_control.toggle_selection()
	player_passive_bar.value = 0
	match Global_Player_Information.character_body_parts["Head"]:
		0:
			player_passive_bar.modulate = Color(Color.WHITE, 0.0)
		1:
			passive_charges_total = 1
		2:
			passive_charges_total = 2
		3:
			passive_charges_total = 0 #DONT NEED TO BE CHARGED
		4:
			passive_charges_total = 1
	player_passive_bar.max_value = passive_charges_total
	player_passive_bar.value = current_passive_charges
	if Global_Player_Information.character_body_parts["Head"] != 0:
		head_r.disabled = true
		head_r.self_modulate = Color(0.303, 0.303, 0.303)
		l_one.get_child(0).text = "CAN'T CHOOSE"
	if Global_Player_Information.character_body_parts["Torso"] != 0:
		torso_r.disabled = true
		torso_r.self_modulate = Color(0.303, 0.303, 0.303)
		l_two.get_child(0).text = "CAN'T CHOOSE"
	if Global_Player_Information.character_body_parts["Left Arm"] != 0:
		arms_r.disabled = true
		arms_r.self_modulate = Color(0.303, 0.303, 0.303)
		l_three.get_child(0).text = "CAN'T CHOOSE"
	if Global_Player_Information.character_body_parts["Legs"] != 0:
		legs_r.disabled = true
		legs_r.self_modulate = Color(0.303, 0.303, 0.303)
		l_four.get_child(0).text = "CAN'T CHOOSE"

func player_turn_end():
	await get_tree().create_timer(0.2).timeout
	if battle_has_ended:
		return
	if enemy_is_stunned:
		player_control.toggle_selection()
		enemy_is_stunned = false
		return
	if passive_charges_total > 0 and (current_passive_charges >= passive_charges_total):
		current_passive_charges = 0
		player_body._remove_passive_ability()
	enemy.execute_ability()
	player_control._enter_defense() #THIS IS SO THE PLAYER CAN HAVE THE BUTTON TO PARRY AVAILABLE TO THEM
	#only for spawning a speech bubble
	var _node = speech_bubble.instantiate()
	_node._ready_to_attack()
	speech_bubble_opponent.get_child(0).add_child(_node)

func enemy_turn_end():
	await get_tree().create_timer(0.2).timeout
	if battle_has_ended:
		return
	if player_is_stunned:
		enemy.execute_ability()
		player_control._enter_defense() #THIS IS SO THE PLAYER CAN HAVE THE BUTTON TO PARRY AVAILABLE TO THEM
		player_is_stunned = false
		return
	player_control.toggle_selection()
	pass


func _process(delta: float) -> void:
	player_passive_bar.value = current_passive_charges
	if player_body.health <= 0:
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://Scenes/bedroom.tscn")

#UI CONTROL
func _simple_speech(_option, _color, _from_player: bool): #TO CONTROL SPEECH BUBBLES
	var _node = speech_bubble.instantiate()
	_node._initialize(_option)
	if _from_player:
		speech_bubble_player.get_child(0).add_child(_node)
	else:
		speech_bubble_opponent.get_child(0).add_child(_node)

func _call_damage(_dmg, _color):
	await get_tree().create_timer(0.5).timeout
	var _node = speech_bubble.instantiate()
	_node._calling_damage(_dmg)
	speech_bubble_player.get_child(0).add_child(_node)

#SOUND CONTROL
func _on_music_initial_loop_finished() -> void:
	music_c.playing = true


#control of body part selection

func _end_battle_player_win():
	battle_has_ended = true
	black_panel.show()
	black_panel.self_modulate = Color(Color.WHITE,0.70)
	body_selector.show()
	body_selector.position = Vector2(0, 1097)
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_BACK)
	_tween.tween_property(body_selector, "position", Vector2(0,0), 0.2).from_current()

func _fade_to_black_back_to_bedroom():
	Global_Player_Information.battle_counter += 1
	match battle_id:
		0:
			pass
		1:
			Global_Player_Information.characters_available["Box-er"] = false
		2:
			Global_Player_Information.characters_available["Red Dead"] = false
		3:
			Global_Player_Information.characters_available["Sentry Flash"] = false
		4:
			Global_Player_Information.characters_available["Spark Striker"] = false
		5:
			black_panel.show()
			Global_Player_Information.characters_available["Knightmare"] = false
	if battle_id != 5:
		body_selector.hide()
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_LINEAR)
	_tween.tween_property(black_panel, "self_modulate", Color(Color.WHITE,1), 0.5).from_current()
	await _tween.finished
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://Scenes/bedroom.tscn")
	pass

func _fade_in():
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_LINEAR)
	_tween.tween_property(black_panel, "self_modulate", Color(Color.WHITE,0), 0.5).from(Color(1,1,1,1))
	await _tween.finished
	black_panel.hide()



func _on_head_pressed() -> void:
	if Global_Player_Information.character_body_parts["Head"] != 0:
		return
	
	Global_Player_Information.character_body_parts["Head"] = battle_id
	_fade_to_black_back_to_bedroom()


func _on_head_mouse_entered() -> void:
	if Global_Player_Information.character_body_parts["Head"] != 0:
		return
	var _tween = create_tween()
	_tween.tween_property(head_r, "self_modulate", Color(0.593, 0.593, 0.593), 0.1).from_current()

func _on_head_mouse_exited() -> void:
	if Global_Player_Information.character_body_parts["Head"] != 0:
		return
	var _tween = create_tween()
	_tween.tween_property(head_r, "self_modulate", Color.WHITE, 0.1).from_current()


func _on_torso_pressed() -> void:
	if Global_Player_Information.character_body_parts["Torso"] != 0:
		return
	
	Global_Player_Information.character_body_parts["Torso"] = battle_id
	_fade_to_black_back_to_bedroom()


func _on_torso_mouse_entered() -> void:
	if Global_Player_Information.character_body_parts["Torso"] != 0:
		return
	var _tween = create_tween()
	_tween.tween_property(torso_r, "self_modulate", Color(0.593, 0.593, 0.593), 0.1).from_current()



func _on_torso_mouse_exited() -> void:
	if Global_Player_Information.character_body_parts["Torso"] != 0:
		return
	var _tween = create_tween()
	_tween.tween_property(torso_r, "self_modulate", Color.WHITE, 0.1).from_current()

func _on_arms_pressed() -> void:
	if Global_Player_Information.character_body_parts["Left Arm"] != 0:
		return
	
	Global_Player_Information.character_body_parts["Left Arm"] = battle_id
	Global_Player_Information.character_body_parts["Right Arm"] = battle_id
	_fade_to_black_back_to_bedroom()


func _on_arms_mouse_entered() -> void:
	if Global_Player_Information.character_body_parts["Left Arm"] != 0:
		return
	var _tween = create_tween()
	_tween.tween_property(arms_r, "self_modulate", Color(0.593, 0.593, 0.593), 0.1).from_current()

func _on_arms_mouse_exited() -> void:
	if Global_Player_Information.character_body_parts["Left Arm"] != 0:
		return
	var _tween = create_tween()
	_tween.tween_property(arms_r, "self_modulate", Color.WHITE, 0.1).from_current()

func _on_legs_pressed() -> void:
	if Global_Player_Information.character_body_parts["Legs"] != 0:
		return
	
	Global_Player_Information.character_body_parts["Legs"] = battle_id
	_fade_to_black_back_to_bedroom()


func _on_legs_mouse_entered() -> void:
	if Global_Player_Information.character_body_parts["Legs"] != 0:
		return
	var _tween = create_tween()
	_tween.tween_property(legs_r, "self_modulate", Color(0.593, 0.593, 0.593), 0.1).from_current()

func _on_legs_mouse_exited() -> void:
	if Global_Player_Information.character_body_parts["Legs"] != 0:
		return
	var _tween = create_tween()
	_tween.tween_property(legs_r, "self_modulate", Color.WHITE, 0.1).from_current()
