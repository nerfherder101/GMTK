extends Control
class_name Enemy

@export var base_stats: BaseEnemy
@export var body: Body

@onready var anim : AnimatedSprite2D = $EnemySprite


func _ready() -> void: 
	#$EnemySprite.texture = base_stats.texture
	$EnemySprite.play()
	# confligure healthbar
	body.max_health = base_stats.max_health
	body.health = base_stats.max_health
	body.update_healthbar()

	for ab in base_stats.abilities:
		ab.timing_mg = get_parent().timing_minigame

func do_damage(dmg: int):
	body.do_damage(dmg)
	await get_tree().create_timer(1).timeout


	
	var c = anim.modulate
	c.r += 50
	anim.modulate = c
	
	for i in 50:
		c = anim.modulate
		c.r -= 1
		anim.modulate = c
		await get_tree().create_timer(1/100).timeout
	

func execute_ability(): 
	var rng = RandomNumberGenerator.new()
	var ability_i = rng.randi_range(0, base_stats.abilities.size() - 1)
	var ability = base_stats.abilities[ability_i]
	ability.trigger_ability(get_parent().player_body, body)
	
	await ability.ability_complete
	await get_tree().create_timer(1).timeout
	anim.play("attack")
	await get_tree().create_timer(1).timeout
	anim.play("idle")
	
	get_parent().enemy_turn_end()
