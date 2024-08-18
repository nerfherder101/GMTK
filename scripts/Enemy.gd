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

	for ab in base_stats.abilities:
		ab.timing_mg = get_parent().timing_minigame

func execute_ability(): 
	print("enemy turn callsed")
	var rng = RandomNumberGenerator.new()
	var ability_i = rng.randi_range(0, base_stats.abilities.size() - 1)
	var ability = base_stats.abilities[ability_i]
	ability.trigger_ability(get_parent().player_body, body)
	await ability.ability_complete
	get_parent().enemy_turn_end()
