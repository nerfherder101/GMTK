extends Control

@export var enemy: Enemy = null
@export var player_control: PlayerControl = null


func _ready() -> void:
	player_control.toggle_selection()
	pass

func player_turn_end():
	print("enemy went")
	player_control.toggle_selection()
	pass


func _process(delta: float) -> void:
	pass
