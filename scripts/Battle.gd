extends Control

@export_category("Load Resources")
@export_group("Local Nodes")
@export var enemy: Enemy = null
@export var player_body: Body = null
@export var player_control: PlayerControl = null
@export var timing_minigame: TimingGame = null
@export var speech_bubble_player: MarginContainer
@export var speech_bubble_opponent: MarginContainer
@export_group("UI")
@export var speech_bubble: Resource

func _ready() -> void:
	player_control.toggle_selection()
	pass

func player_turn_end():
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
