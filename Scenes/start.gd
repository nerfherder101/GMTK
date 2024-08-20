extends Node2D


@export var array_all_dialogues_scene_1: Array[String]
@export var array_all_dialogues_scene_2: Array[String]

@onready var start_button = %Start
@onready var option_button = %Options
@onready var black_screen = %Black_Screen
@onready var gray_panel = %Gray_Panel
@onready var title = %Title
@onready var button_container = %Button_Container


@onready var audio_node = $Audio
@onready var music_i = %Music_InitialLoop
@onready var music_c = %Music_ContinuousLoop
@onready var sfx_hover = %SFX_Hover
@onready var sfx_accept = %SFX_Accept
@onready var sfx_back = %SFX_Back

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
			if Input.is_action_just_pressed("ui_accept"):
				current_scene = 2
				entered = false
				return
			if !entered:
				_start_first_dialogue()
			entered = true
		2:
			pass
		3:
			pass
		4:
			pass

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
	await _tween.finished
	await get_tree().create_timer(1).timeout
	current_scene = 1


func _on_music_initial_loop_finished() -> void:
	music_c.playing = true


func _on_start_mouse_entered() -> void:
	sfx_hover.play()


func _on_options_mouse_entered() -> void:
	sfx_hover.play()

func _start_first_dialogue():
	var _array_options: int = 0
	
	pass
