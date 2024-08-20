extends Node

@export var speech_bubble: Resource = preload("res://scripts/UI Elements/speech_bubble_in_overworld.tscn")
@export var array_all_dialogues_scene_1: Array[String]
@export var array_all_dialogues_scene_2: Array[String]
@export var array_all_dialogues_scene_3: Array[String]
@export var array_all_dialogues_scene_4: Array[String]
@export var array_all_dialogues_scene_5: Array[String]
@export var array_all_dialogues_scene_6: Array[String]
@export var array_all_dialogues_scene_7: Array[String]
@export var array_all_dialogues_scene_8: Array[String]
@export var array_all_dialogues_scene_9: Array[String]
@export var array_all_dialogues_scene_10: Array[String]
@export var array_all_dialogues_scene_11: Array[String]
@export var array_all_dialogues_scene_12: Array[String]
@export var array_all_dialogues_scene_13: Array[String]
@export var array_all_dialogues_scene_14: Array[String]

@onready var black_panel = %Black_Panel
@onready var boxer_dead = %Boxer_Dead
func _ready() -> void:
	match Global_Player_Information.battle_counter:
		0:
			boxer_dead.show()
			
		1:
			pass
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass


func _fade_in():
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_LINEAR)
	_tween.tween_property(black_panel, "self_modulate", Color(Color.WHITE,0), 0.5).from(Color(1,1,1,1))
	await _tween.finished
	black_panel.hide()
