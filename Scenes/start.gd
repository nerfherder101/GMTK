extends Node2D

@export var speech_bubble: Resource = preload("res://scripts/UI Elements/speech_bubble_in_overworld.tscn")
@export var array_all_dialogues_scene_1: Array[String]
@export var array_all_dialogues_scene_2: Array[String]
@export var array_all_dialogues_scene_3: Array[String]

@onready var start_button = %Start
@onready var option_button = %Options
@onready var black_screen = %Black_Screen
@onready var gray_panel = %Gray_Panel
@onready var title = %Title
@onready var button_container = %Button_Container
@onready var mono = %Mono

@onready var audio_node = $Audio
@onready var music_i = %Music_InitialLoop
@onready var music_c = %Music_ContinuousLoop
@onready var sfx_hover = %SFX_Hover
@onready var sfx_accept = %SFX_Accept
@onready var sfx_back = %SFX_Back
@onready var sfx_lil_bro = %SFX_LilBro
@onready var sfx_player = %SFX_Player

@onready var current_speeches: Array
@onready var current_scene = 0
@onready var entered: bool = false

func _ready() -> void:
	black_screen.show()
	button_container.show()
	title.position = Vector2(460, -740)
	button_container.position = Vector2(730, 1091)
	var _tween = create_tween()
	_tween.set_parallel(true)
	_tween.tween_property(black_screen, "self_modulate", Color(1,1,1,0), 0.5).from_current()
	_tween.tween_property(title, "position", Vector2(460, -252), 0.6).from_current()
	await _tween.finished
	var _tween2 = create_tween()
	_tween2.set_ease(Tween.EASE_OUT)
	_tween2.set_trans(Tween.TRANS_BACK)
	_tween2.tween_property(button_container, "position", Vector2(730, 603), 0.4).from_current()
	await _tween2.finished
	black_screen.hide()

func _process(delta: float) -> void:
	match current_scene:
		0:
			pass
		1:
			if !entered:
				_start_first_dialogue()
			entered = true
		2:
			if !entered:
				_start_second_dialogue()
			entered = true
		3:
			if !entered:
				_start_third_dialogue()
			entered = true
		4:
			if !entered:
				_start_fourth_dialogue()
			entered = true



func _on_start_pressed() -> void:
	sfx_accept.play()
	var _tween = create_tween()
	_tween.set_parallel(true)
	_tween.tween_property(gray_panel, "self_modulate", Color(1,1,1,0), 0.3).from_current()
	_tween.tween_property(title, "position", Vector2(460, -740), 0.3).from_current()
	_tween.tween_property(button_container, "position", Vector2(730, 1091), 0.3).from_current()
	await _tween.finished
	button_container.hide()
	title.hide()
	await get_tree().create_timer(1).timeout
	current_scene = 1

func _fade_to_black():
	black_screen.show()
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_LINEAR)
	_tween.tween_property(black_screen, "self_modulate", Color(Color.WHITE,1), 0.5).from_current()
	await _tween.finished
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://battle scenes/BoxerBattle.tscn")

func _on_music_initial_loop_finished() -> void:
	music_c.playing = true


func _on_start_mouse_entered() -> void:
	sfx_hover.play()


func _on_options_mouse_entered() -> void:
	sfx_hover.play()

func _start_first_dialogue():
	#var _array_options: int = 0
	for n in array_all_dialogues_scene_1.size():
		current_speeches.append(speech_bubble.instantiate())
		current_speeches[n]._initialize(array_all_dialogues_scene_1[n])
		add_child(current_speeches[n])
		await get_tree().create_timer(0.1).timeout
		current_speeches[n].position_in_y = 150 + (150 * n)
		if n == 0 or n == 2 or n == 4:
			current_speeches[n].position_in_x = 100
		else:
			current_speeches[n].position_in_x = 1300
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(2).timeout
	for n in current_speeches.size():
			current_speeches[n].queue_free()
	current_speeches.clear()
	sfx_accept.play()
	current_scene = 2
	entered = false


func _start_second_dialogue():
	current_speeches.append(speech_bubble.instantiate())
	current_speeches[0]._initialize(array_all_dialogues_scene_2[0])
	add_child(current_speeches[0])
	await get_tree().create_timer(0.1).timeout
	current_speeches[0].position_in_y = 300
	current_speeches[0].position_in_x = 1300
	await get_tree().create_timer(2).timeout
	for n in current_speeches.size():
			current_speeches[n].queue_free()
	current_speeches.clear()
	sfx_accept.play()
	current_scene = 3
	entered = false

func _start_third_dialogue():
	mono.show()
	var _tween = create_tween()
	_tween.set_parallel(true)
	_tween.tween_property(gray_panel, "self_modulate", Color(1,1,1,0.5), 0.3).from_current()
	_tween.tween_property(mono, "self_modulate", Color(1,1,1,1), 0.3).from(Color(1,1,1,0))
	await get_tree().create_timer(2).timeout
	sfx_accept.play()
	mono.hide()
	gray_panel.hide()
	current_scene = 4
	entered = false
	return

func _start_fourth_dialogue():
	current_speeches.append(speech_bubble.instantiate())
	current_speeches[0]._initialize(array_all_dialogues_scene_3[0])
	add_child(current_speeches[0])
	await get_tree().create_timer(0.1).timeout
	current_speeches[0].position_in_y = 300
	current_speeches[0].position_in_x = 100
	await get_tree().create_timer(0.5).timeout
	await get_tree().create_timer(2).timeout
	for n in current_speeches.size():
			current_speeches[n].queue_free()
	current_speeches.clear()
	sfx_accept.play()
	current_scene = 5
	_fade_to_black()
