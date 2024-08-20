extends Node

@export var speech_bubble: Resource = preload("res://scripts/UI Elements/speech_bubble_in_overworld.tscn")
@export var speech_bubble_red: Resource = preload("res://scripts/UI Elements/speech_bubble_in_overworld_red.tscn")
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
@onready var blue_filter = %Blue_Filter
@onready var boxer_dead = %Boxer_Dead
@onready var bedroom = $Bedroom
@onready var shelf = $Shelf
@onready var figurines = $"All Figurines"

@onready var audio_node = $Audio
@onready var music_i = %Music_InitialLoop
@onready var music_c = %Music_ContinuousLoop
@onready var sfx_hover = %SFX_Hover
@onready var sfx_accept = %SFX_Accept
@onready var sfx_back = %SFX_Back

@onready var current_speeches: Array
@onready var current_scene = 0
@onready var entered: bool = false

func _ready() -> void:
	Global_Player_Information.battle_counter = 4
	black_panel.show()
	_fade_in()
	match Global_Player_Information.battle_counter:
		1:
			boxer_dead.show()
			bedroom.show()
			shelf.hide()
			figurines.hide()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_1[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 100
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_1[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 1300
			await get_tree().create_timer(2).timeout
			#end of 1
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_2[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 100
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_2[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 1300
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[2]._initialize(array_all_dialogues_scene_2[2])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[2].position_in_y = 150 + (150 * 2)
			current_speeches[2].position_in_x = 100
			await get_tree().create_timer(2).timeout
			#end of 2
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			await get_tree().create_timer(0.1).timeout
			shelf.show()
			figurines.show()
		2:
			bedroom.show()
			shelf.hide()
			figurines.hide()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_3[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 100
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_3[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 1300
			await get_tree().create_timer(2).timeout
			#end of 1
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_4[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 100
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_4[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 1300
			await get_tree().create_timer(2).timeout
			#end of 2
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			await get_tree().create_timer(0.1).timeout
			shelf.show()
			figurines.show()
		3:
			bedroom.show()
			shelf.hide()
			figurines.hide()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_5[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 100
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_5[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 1300
			await get_tree().create_timer(2).timeout
			#end of 1
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_6[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 1300
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_6[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 100
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[2]._initialize(array_all_dialogues_scene_6[2])
			add_child(current_speeches[2])
			await get_tree().create_timer(0.1).timeout
			current_speeches[2].position_in_y = 150 + (150 * 2)
			current_speeches[2].position_in_x = 1300
			await get_tree().create_timer(2).timeout
			#end of 2
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			await get_tree().create_timer(0.1).timeout
			shelf.show()
			figurines.show()
		4:
			bedroom.show()
			shelf.hide()
			figurines.hide()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_7[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 100
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_7[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 1300
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[2]._initialize(array_all_dialogues_scene_7[2])
			add_child(current_speeches[2])
			await get_tree().create_timer(0.1).timeout
			current_speeches[2].position_in_y = 150 + (150 * 2)
			current_speeches[2].position_in_x = 100
			await get_tree().create_timer(1.5).timeout
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			black_panel.show()
			black_panel.self_modulate = Color(1,1,1,1)
			await get_tree().create_timer(2).timeout
			blue_filter.show()
			black_panel.hide()
			await get_tree().create_timer(1).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_8[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 1300
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_8[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 1300
			await get_tree().create_timer(2).timeout
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			current_speeches.append(speech_bubble_red.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_9[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 600
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble_red.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_9[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 600
			await get_tree().create_timer(4).timeout
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			black_panel.show()
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://battle scenes/KnightBattle.tscn")
		5:
			bedroom.show()
			shelf.hide()
			figurines.hide()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_11[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 600
			await get_tree().create_timer(2).timeout
			#end of 1
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_12[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 1300
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_12[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 100
			await get_tree().create_timer(2).timeout
			#end of 2
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[0]._initialize(array_all_dialogues_scene_13[0])
			add_child(current_speeches[0])
			await get_tree().create_timer(0.1).timeout
			current_speeches[0].position_in_y = 150 + (150 * 0)
			current_speeches[0].position_in_x = 1300
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[1]._initialize(array_all_dialogues_scene_13[1])
			add_child(current_speeches[1])
			await get_tree().create_timer(0.1).timeout
			current_speeches[1].position_in_y = 150 + (150 * 1)
			current_speeches[1].position_in_x = 100
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[2]._initialize(array_all_dialogues_scene_13[2])
			add_child(current_speeches[2])
			await get_tree().create_timer(0.1).timeout
			current_speeches[2].position_in_y = 150 + (150 * 2)
			current_speeches[2].position_in_x = 1300
			await get_tree().create_timer(0.2).timeout
			current_speeches.append(speech_bubble.instantiate())
			current_speeches[3]._initialize(array_all_dialogues_scene_13[3])
			add_child(current_speeches[3])
			await get_tree().create_timer(0.1).timeout
			current_speeches[3].position_in_y = 150 + (150 * 3)
			current_speeches[3].position_in_x = 100
			await get_tree().create_timer(3).timeout
			#end of 3
			for n in current_speeches.size():
				current_speeches[n].queue_free()
			current_speeches.clear()
			for n in 8:
				var _n = n
				current_speeches.append(speech_bubble.instantiate())
				current_speeches[_n]._initialize(array_all_dialogues_scene_14[_n])
				add_child(current_speeches[_n])
				await get_tree().create_timer(0.1).timeout
				if n < 4:
					current_speeches[_n].position_in_y = 150 + (150 * _n)
					current_speeches[_n].position_in_x = 100
				else:
					current_speeches[_n].position_in_y = 150 + (150 * (_n-4))
					current_speeches[_n].position_in_x = 1300
				await get_tree().create_timer(0.2).timeout


func _process(delta: float) -> void:
	pass

func _fade_in():
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_LINEAR)
	_tween.tween_property(black_panel, "self_modulate", Color(Color.WHITE,0), 0.5).from(Color(1,1,1,1))
	await _tween.finished
	black_panel.hide()


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
		await get_tree().create_timer(1.5).timeout


func _on_music_initial_loop_finished() -> void:
	music_c.playing = true
