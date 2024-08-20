extends Control

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

func _ready() -> void:
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

func player_turn_end():
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
	player_control.toggle_selection()
	pass


func _process(delta: float) -> void:
	pass

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
