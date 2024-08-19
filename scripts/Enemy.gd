extends Node2D
class_name Enemy

@export var base_stats: BaseEnemy
@export var body: Body



signal attack_finished()


func _ready() -> void: 
	# confligure healthbar
	await get_tree().create_timer(0.1).timeout
	body.max_health = base_stats.max_health
	body.health = base_stats.max_health
	body.update_healthbar()

	for ab in base_stats.abilities:
		ab.timing_mg = get_parent().timing_minigame

func do_damage(dmg: int):
	body.do_damage(dmg)
	#await get_tree().create_timer(1).timeout
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_LINEAR)
	var anim: Sprite2D = body.sprite
	_tween.tween_property(anim,"modulate", Color.WHITE, 0.5).from(Color.RED)
	await _tween.finished
	anim.modulate = Color.WHITE
	

func execute_ability(): 
	var rng = RandomNumberGenerator.new()
	var ability_i = rng.randi_range(0, base_stats.abilities.size() - 1)
	var ability = base_stats.abilities[ability_i]
	var anim = body.sprite
	var _timer_to_attack = base_stats.base_attack_timer
	anim.modulate = Color.YELLOW
	await get_tree().create_timer(rng.randf_range(_timer_to_attack - 0.3,_timer_to_attack + 0.3)).timeout
	anim.modulate = Color.ORANGE
	await get_tree().create_timer(0.4).timeout
	anim.modulate = Color.RED
	await get_tree().create_timer(0.15).timeout
	anim.modulate = Color.WHITE
	body.current_state_anim = body.state_anim.attacking	
	ability._trigger_ability_2(get_parent().player_body, body)
	await attack_finished
	
	get_parent().enemy_turn_end()

func _animation_finished():
	emit_signal("attack_finished")
