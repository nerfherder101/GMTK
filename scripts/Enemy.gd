extends Node2D
class_name Enemy

@export var body: Body

@export_category("General Info")
@export var base_attack_timer: float = 2.0
@export var base_strength: int = 1
@export var base_defense: int = 1
@export var final_boss: bool = false


@export_category("Special Effects")
@export var vfx: Resource
@export var sfx: Resource


signal attack_finished()


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
	var _color1: Color = Color.YELLOW
	var _color2: Color = Color.ORANGE
	var _color3: Color = Color.RED
	if final_boss:
		var _which_color = rng.randi_range(0,2)
		match _which_color:
			0:
				_color1 = Color.ORANGE
				_color2 = Color.YELLOW
				_color3 = Color.RED
			1:
				_color1 = Color.RED
				_color2 = Color.YELLOW
				_color3 = Color.ORANGE
			2:
				_color1 = Color.YELLOW
				_color2 = Color.RED
				_color3 = Color.ORANGE
	
	
	anim.modulate = _color1
	await get_tree().create_timer(rng.randf_range(base_attack_timer - 0.3, base_attack_timer + 0.3)).timeout
	anim.modulate = _color2
	await get_tree().create_timer(0.4).timeout
	anim.modulate = _color3
	await get_tree().create_timer(0.15).timeout
	anim.modulate = Color.WHITE
	body.current_state_anim = body.state_anim.attacking	

	var player_body = get_parent().player_body
	var dmg = base_strength + body.strength
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
	
	await get_tree().create_timer(1.4).timeout
	
	body.battle_screen.enemy_turn_end()

func _animation_finished():
	emit_signal("attack_finished")
