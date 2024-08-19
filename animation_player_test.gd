extends Node2D

@export var all_profiles: Array[Body_Part] = [preload("res://resources/bodyparts/base/base_torso.tres"), preload("res://resources/bodyparts/base/base_head.tres"), preload("res://resources/bodyparts/base/base_larm.tres"), preload("res://resources/bodyparts/base/base_rarm.tres"), preload("res://resources/bodyparts/base/base_legs.tres"),
preload("res://resources/bodyparts/boxer/boxer_torso.tres"), preload("res://resources/bodyparts/boxer/boxer_head.tres"), preload("res://resources/bodyparts/boxer/boxer_larm.tres"), preload("res://resources/bodyparts/boxer/boxer_rarm.tres"), preload("res://resources/bodyparts/boxer/boxer_legs.tres"),
preload("res://resources/bodyparts/reddead/red_torso.tres"),preload("res://resources/bodyparts/reddead/red_head.tres"), preload("res://resources/bodyparts/reddead/red_larm.tres"), preload("res://resources/bodyparts/reddead/red_rarm.tres"), preload("res://resources/bodyparts/reddead/red_legs.tres"),
preload("res://resources/bodyparts/sentryflash/sentry_torso.tres"), preload("res://resources/bodyparts/sentryflash/sentry_head.tres"), preload("res://resources/bodyparts/sentryflash/sentry_larm.tres"), preload("res://resources/bodyparts/sentryflash/sentry_rarm.tres"), preload("res://resources/bodyparts/sentryflash/sentry_legs.tres"),
preload("res://resources/bodyparts/sparkstriker/spark_torso.tres"), preload("res://resources/bodyparts/sparkstriker/spark_head.tres"), preload("res://resources/bodyparts/sparkstriker/spark_larm.tres"), preload("res://resources/bodyparts/sparkstriker/spark_rarm.tres"), preload("res://resources/bodyparts/sparkstriker/spark_legs.tres")]
@export var all_textures: Array[Resource] = [preload("res://art/character art/Individual Pieces/MODBase.png"), preload("res://art/character art/Individual Pieces/MODBoxer.png"), preload("res://art/character art/Individual Pieces/MODRedDead.png"), preload("res://art/character art/Individual Pieces/MODSentryFlash.png"), preload("res://art/character art/Individual Pieces/MODSparkStriker.png")]

@onready var larm_joint = %Larm_Joint
@onready var rarm_joint = %RArm_Joint
@onready var torso_location = %Torso_Location
@onready var torso_joint = %Torso_Joint
@onready var legs_joint = %Legs_Joint
@onready var head_joint = %Head_Joint

func _ready() -> void:
	
	pass
