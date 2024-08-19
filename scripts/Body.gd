extends Node2D
class_name Body

@export var max_health := 100
var health = 0

@export var health_bar : ProgressBar = null

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

enum state_anim {idle, attacking, wait, on_hit, explode}
@onready var current_state_anim: int = 0


func _ready() -> void:
	await get_tree().physics_frame
	health = max_health
	health_bar.max_value = max_health
	update_healthbar()

func _process(delta: float) -> void:
	match current_state_anim:
		state_anim.idle:
			animation_player.play("Idle")
			current_state_anim = state_anim.wait
		state_anim.attacking:
			animation_player.animation_set_next("Attack", "Idle")
			animation_player.play("Attack")
			current_state_anim = state_anim.wait
		state_anim.wait:
			pass
	pass

func do_damage(dmg: int):
	health -= dmg
	update_healthbar()

func update_healthbar() -> void:
	health_bar.value = health
	pass

func _animation_finished():
	current_state_anim = state_anim.idle
	get_parent()._animation_finished()
