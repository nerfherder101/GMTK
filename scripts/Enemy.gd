extends Control
class_name Enemy

@export var base_stats: BaseEnemy
@export var body: Body

func _ready() -> void: 
	$EnemyPicture.texture = base_stats.texture
	body.max_health = base_stats.max_health
	body.health = base_stats.max_health
	body.update_healthbar()
