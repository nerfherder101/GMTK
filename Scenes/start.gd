extends Node2D

@onready var start_button = %Start
@onready var option_button = %Options
@onready var black_screen = %Black_Screen
@onready var gray_panel = %Gray_Panel
@onready var title = %Title
@onready var button_container = %Button_Container

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


func _on_start_pressed() -> void:
	var _tween = create_tween()
	_tween.set_parallel(true)
	_tween.tween_property(gray_panel, "self_modulate", Color(1,1,1,0), 0.3).from_current()
	_tween.tween_property(title, "position", Vector2(460, -740), 0.3).from_current()
	_tween.tween_property(button_container, "position", Vector2(730, 1091), 0.3).from_current()
	await _tween.finished
	button_container.hide()
	title.hide()
