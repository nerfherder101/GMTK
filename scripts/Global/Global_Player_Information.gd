extends Node

@onready var is_music_muted: bool = false
@onready var is_sfx_muted: bool = false

@onready var characters_available = {
	"Box-er" : true,
	"Red Dead" : false,
	"Sentry Flash" : false,
	"Spark Striker" : false,
	"Knightmare" : false
}

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
