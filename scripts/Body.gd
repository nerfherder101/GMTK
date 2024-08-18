extends Node
class_name Body

@export var max_health := 100
var health = 0

@export var health_bar : ProgressBar = null
@export var health_label : Label = null

func _ready() -> void:
	await get_tree().physics_frame
	health = max_health
	health_bar.max_value = max_health
	update_healthbar()

func do_damage(dmg: int):
	health -= dmg
	update_healthbar()

func update_healthbar() -> void:
	health_label.text = "HP: " + str(health) + "/" + str(max_health)
	health_bar.value = health
	pass
