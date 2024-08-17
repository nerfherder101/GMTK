extends Control
class_name Enemy

@export var base_stats: BaseEnemy
@export var body: Body

func _ready() -> void: 
	$EnemyPicture.texture = base_stats.texture
	
	# confligure healthbar
	body.max_health = base_stats.max_health
	body.health = base_stats.max_health
	body.update_healthbar()



func execute_ability(): 
	var rng = RandomNumberGenerator.new()
	var ability = rng.randi_range(0, base_stats.abilities.size() - 1)
	base_stats.abilities[ability].trigger_ability(get_parent().player_body, body)
	
	get_parent().enemy_turn_end()
