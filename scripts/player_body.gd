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
	current_body_parts.append(all_profiles[0 +  (5 * Global_Player_Information.character_body_parts["Torso"])])
	current_body_parts.append(all_profiles[1 +  (5 * Global_Player_Information.character_body_parts["Head"])])
	current_body_parts.append(all_profiles[2 +  (5 * Global_Player_Information.character_body_parts["Left Arm"])])
	current_body_parts.append(all_profiles[3 +  (5 * Global_Player_Information.character_body_parts["Right Arm"])])
	current_body_parts.append(all_profiles[4 +  (5 * Global_Player_Information.character_body_parts["Legs"])])

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

func _do_passive_ability():
	match Global_Player_Information.character_body_parts["Head"]:
		0:
			pass
		1:
			strength += 1
			Global_Player_Information.character_attributes["strength"] = strength
		2:
			critical_chance += 1.0
			Global_Player_Information.character_attributes["critical chance"] = critical_chance
		3:
			battle_screen.enemy_is_stunned = true
		4:
			pass
	

func _remove_passive_ability():
	match Global_Player_Information.character_body_parts["Head"]:
		0:
			pass
		1:
			strength -= 1
			Global_Player_Information.character_attributes["strength"] = strength
		2:
			critical_chance -= 1.0
			Global_Player_Information.character_attributes["critical chance"] = critical_chance
		3:
			pass
		4:
			pass


#PLAYER BODY SPEECH
func _not_parry():
	battle_screen._simple_speech(2, 0, true)

@onready var passive_charges_total: int = -1
@onready var current_passive_charges: int = 0

func _success_parry():
	var _head = Global_Player_Information.character_body_parts["Head"]
	if hp > 0:
		if _head != 0 or _head != 2: 
			if current_passive_charges < passive_charges_total:
				current_passive_charges += 1
			if current_passive_charges >= passive_charges_total:
				_do_passive_ability()
		elif _head == 2:
			battle_screen.enemy._do_true_damage(1)
			pass
		battle_screen._simple_speech(0, 0, true)
