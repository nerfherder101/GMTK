extends Node
class_name Body

@export var max_health := 100
var health = max_health

@export var health_bar : ProgressBar = null
@export var health_label : Label = null

func _ready() -> void:
	health_bar.max_value = max_health
	update_healthbar()
	pass	

func do_damage(dmg: int):
	health -= dmg
	update_healthbar()

func update_healthbar() -> void:
	health_label.text = "HP: " + str(health) + "/" + str(max_health)
	health_bar.value = health
	pass
