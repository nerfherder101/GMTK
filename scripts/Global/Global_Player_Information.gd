extends Node

@onready var is_music_muted: bool = false
@onready var is_sfx_muted: bool = false

@onready var characters_available = {
	"Box-er" : true,
	"Red Dead" : true,
	"Sentry Flash" : true,
	"Spark Striker" : true,
	"Knightmare" : true
}
@onready var battle_counter: int = 0

#assign after a combat finish for customization screen
@onready var last_combat: int = 1

@onready var character_attributes = {
		"strength" : 0,
		"defense" : 0,
		"agility" : 0,
		"critical chance" : 0
	}

@onready var character_body_parts = {
	"Torso" : 0,
	"Head"  : 0,
	"Left Arm" : 0,
	"Right Arm" : 0,
	"Legs" : 0
}
