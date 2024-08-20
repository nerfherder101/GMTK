extends Body
@export var all_profiles: Array[Body_Part] = [preload("res://resources/bodyparts/base/base_torso.tres"), preload("res://resources/bodyparts/base/base_head.tres"), preload("res://resources/bodyparts/base/base_larm.tres"), preload("res://resources/bodyparts/base/base_rarm.tres"), preload("res://resources/bodyparts/base/base_legs.tres"),
preload("res://resources/bodyparts/boxer/boxer_torso.tres"), preload("res://resources/bodyparts/boxer/boxer_head.tres"), preload("res://resources/bodyparts/boxer/boxer_larm.tres"), preload("res://resources/bodyparts/boxer/boxer_rarm.tres"), preload("res://resources/bodyparts/boxer/boxer_legs.tres"),
preload("res://resources/bodyparts/red/red_torso.tres"),preload("res://resources/bodyparts/red/red_head.tres"), preload("res://resources/bodyparts/red/red_larm.tres"), preload("res://resources/bodyparts/red/red_rarm.tres"), preload("res://resources/bodyparts/red/red_legs.tres"),
preload("res://resources/bodyparts/sentryflash/sentry_torso.tres"), preload("res://resources/bodyparts/sentryflash/sentry_head.tres"), preload("res://resources/bodyparts/sentryflash/sentry_larm.tres"), preload("res://resources/bodyparts/sentryflash/sentry_rarm.tres"), preload("res://resources/bodyparts/sentryflash/sentry_legs.tres"),
preload("res://resources/bodyparts/sparkstriker/spark_torso.tres"), preload("res://resources/bodyparts/sparkstriker/spark_head.tres"), preload("res://resources/bodyparts/sparkstriker/spark_larm.tres"), preload("res://resources/bodyparts/sparkstriker/spark_rarm.tres"), preload("res://resources/bodyparts/sparkstriker/spark_legs.tres")]
@export var all_textures: Array[Resource] = [preload("res://art/character art/Individual Pieces/MODBase.png"), preload("res://art/character art/Individual Pieces/MODBoxer.png"), preload("res://art/character art/Individual Pieces/MODRedDead.png"), preload("res://art/character art/Individual Pieces/MODSentryFlash.png"), preload("res://art/character art/Individual Pieces/MODSparkStriker.png")]

@onready var bodyparts = $Bodyparts
@onready var larm_joint = %Larm_Joint
@onready var rarm_joint = %RArm_Joint
@onready var torso_location = %Torso_Location
@onready var torso_joint = %Torso_Joint
@onready var legs_joint = %Legs_Joint
@onready var head_joint = %Head_Joint
@onready var current_body_parts: Array[Body_Part]

func _ready() -> void:
	await get_tree().physics_frame
	sprite = $Bodyparts
	health = max_health
	health_bar.max_value = max_health
	update_healthbar()
	current_body_parts.clear()
	
	
	current_body_parts.append(all_profiles[0 + Global_Player_Information.character_body_parts["Torso"] * 5])
	current_body_parts.append(all_profiles[1 + Global_Player_Information.character_body_parts["Head"] * 5])
	current_body_parts.append(all_profiles[2 + Global_Player_Information.character_body_parts["Left Arm"] * 5])
	current_body_parts.append(all_profiles[3 + Global_Player_Information.character_body_parts["Right Arm"] * 5])
	current_body_parts.append(all_profiles[4 + Global_Player_Information.character_body_parts["Legs"] * 5])
	_update_appearance()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		var rng = RandomNumberGenerator.new()
		var _c: int = current_body_parts.size()
		current_body_parts.clear()
		for n in _c:
			if n == 3:
				current_body_parts.append(all_profiles[n + (current_body_parts[2].character_base * 5)])
				continue
			current_body_parts.append(all_profiles[n + (rng.randi_range(0,4) * 5)])
		_update_appearance()
		
func _update_appearance():
	
	
	
	for n in current_body_parts.size():
		var _location_in_array = all_profiles[current_body_parts[n].body_part_id + (5 * current_body_parts[n].character_base)]
		var _bodypart_sprite = null
		var _body_particle = null
		match current_body_parts[n].body_part_id:
			0:
				_bodypart_sprite = torso_joint.get_child(0)
				_body_particle = torso_particle
			1:
				_bodypart_sprite = head_joint.get_child(0)
				_body_particle = head_particle
			2:
				_bodypart_sprite = larm_joint.get_child(0)
				_body_particle = arms_particle
			3:
				_bodypart_sprite = rarm_joint.get_child(0)
			4:
				_bodypart_sprite = legs_joint.get_child(0)
				_body_particle = legs_particle
		if _bodypart_sprite  == null:
			continue
		_bodypart_sprite.visible = current_body_parts[n].visible
		_bodypart_sprite.texture = all_textures[current_body_parts[n].character_base]
		if _body_particle:
			_body_particle.texture.atlas = all_textures[current_body_parts[n].character_base]
		_bodypart_sprite.position = current_body_parts[n].joint_location
		strength += current_body_parts[n].strength
		defense += current_body_parts[n].defense
		agility += current_body_parts[n].agility
		critical_chance += current_body_parts[n].crit_chance
	Global_Player_Information.character_attributes["strength"] = strength
	Global_Player_Information.character_attributes["defense"] = defense
	Global_Player_Information.character_attributes["agility"] = agility
	Global_Player_Information.character_attributes["critical chance"] = critical_chance

#REPLACES BODY FUNCTION
func do_damage(dmg: int):
	var _true_damage = dmg - Global_Player_Information.character_attributes["defense"]
	if _true_damage < 0:
		_true_damage = 0
	health -= _true_damage
	sfx_hurt.play()
	if health <= 0:
		sfx_explode.play()
		current_state_anim = state_anim.explode
	update_healthbar()
