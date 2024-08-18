extends Control

@export var enemy: Enemy = null
@export var player_body: Body = null
@export var player_control: PlayerControl = null
@export var timing_minigame: TimingGame = null

func _ready() -> void:
	player_control.toggle_selection()
	pass

func player_turn_end():
	enemy.execute_ability()
	pass

func enemy_turn_end():
	player_control.toggle_selection()
	pass


func _process(delta: float) -> void:
	pass
