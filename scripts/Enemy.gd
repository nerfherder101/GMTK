extends Node2D
class_name Enemy

@export var body: Body

@export_category("General Info")
@export var texture: Texture = null
@export var base_health := 10
@export var base_attack_timer: float = 2.0
@export var base_strength: int = 1
@export var base_defense: int = 1


@export_category("Special Effects")
@export var vfx: Resource
@export var sfx: Resource


signal attack_finished()


func _ready() -> void: 
	# confligure healthbar
	await get_tree().create_timer(0.1).timeout
	body.max_health = base_health
	body.health = base_health
	body.update_healthbar()
	
func do_damage(dmg: int):
	body.do_damage(dmg)
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_LINEAR)
	var anim: Sprite2D = body.sprite
	_tween.tween_property(anim,"modulate", Color.WHITE, 0.5).from(Color.RED)
	await _tween.finished
	anim.modulate = Color.WHITE
	

func execute_ability(): 
	
	var rng = RandomNumberGenerator.new()
	var anim = body.sprite
	
	anim.modulate = Color.YELLOW
	await get_tree().create_timer(rng.randf_range(base_attack_timer - 0.3, base_attack_timer + 0.3)).timeout
	anim.modulate = Color.ORANGE
	await get_tree().create_timer(0.4).timeout
	anim.modulate = Color.RED
	await get_tree().create_timer(0.15).timeout
	anim.modulate = Color.WHITE
	body.current_state_anim = body.state_anim.attacking	

	var player_body = get_parent().player_body
	var dmg = (base_strength + body.strength) - player_body.defense #FORMULA TO CALCULATE THE DAMAGE THE PLAYER WILL RECEIVE: BASE STRENGTH OF THE PROFILE + ANY ADDITIONAL STRENGTH - THE PLAYER'S DEFENSE
	if player_body.control.parrying:
		dmg -= 1
		player_body._success_parry() #JUST TO CONTROL SPEECH BUBBLES
		body._missed()
	else:
		player_body._not_parry() #JUST TO CONTROL SPEECH BUBBLES
		if vfx != null:
			player_body.add_child(vfx.instantiate())
		body._successful_attack()
	player_body.do_damage(dmg)
	
	await attack_finished
	
	get_parent().enemy_turn_end()

func _animation_finished():
	emit_signal("attack_finished")
