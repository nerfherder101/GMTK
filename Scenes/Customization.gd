extends Control

@onready var last_combat = Global_Player_Information.last_combat

@export var body_images: Array[TextureRect]

@export var all_textures: Array[Resource] = [preload("res://art/character art/Individual Pieces/MODBase.png"), preload("res://art/character art/Individual Pieces/MODBoxer.png"), preload("res://art/character art/Individual Pieces/MODRedDead.png"), preload("res://art/character art/Individual Pieces/MODSentryFlash.png"), preload("res://art/character art/Individual Pieces/MODSparkStriker.png")]

@export var head_button: Button
@export var chest_button: Button
@export var arms_button: Button
@export var legs_button: Button

@export var head_label: Label
@export var chest_label: Label
@export var arms_label: Label
@export var legs_label: Label

 #0 base, 1 boxer, 2 reddead, 3 robot, 4 sparkstriker
func get_body_name(id: int) -> String:
	match id:
		0:
			return "base"
		1:
			return "boxer"
		2:
			return "red"
		3:
			return "sentry"
		4:
			return "sparkstriker"
		_:
			return "error"
			
#0 torso, 1 head, 2 Larm, 3 Rarm, 4 legs
func get_part_name(id: int) -> String:
	match id:
		0:
			return "Torso"
		1: 
			return "Head"
		2: 
			return "Left Arm"
		3: 
			return "Right Arm"
		4: 
			return "Legs"
		_:
			return "error"
			
func _ready() -> void:
	var texture = all_textures[last_combat]
	body_images[0].texture = texture
	
	head_button.pressed.connect(head_selected)
	
	
	chest_button.pressed.connect(chest_selected)
	arms_button.pressed.connect(arms_selected)
	legs_button.pressed.connect(legs_selected)
	
	var name = get_body_name(last_combat)
	
	var rec = load("res://resources/bodyparts/" + name + "/" + name+ "_head.tres")
	print("res://resources/bodyparts/" + name + "/" + name+ "_head.tres")
	fill_label(rec, head_label)
	
	rec = load("res://resources/bodyparts/" + name + "/" + name+ "_torso.tres")
	print("res://resources/bodyparts/" + name + "/" + name+ "_head.tres")
	fill_label(rec, chest_label)
	rec = load("res://resources/bodyparts/" + name + "/" + name+ "_larm.tres")
	print("res://resources/bodyparts/" + name + "/" + name+ "_larm.tres")

	fill_label(rec, arms_label)
	rec = load("res://resources/bodyparts/" + name + "/" + name+ "_legs.tres")
	if not rec: 
		print("res://resources/bodyparts/" + name + "/" + name+ "_head.tres")
	fill_label(rec, legs_label)
	
func fill_label(part: Body_Part, label: Label):
	
	var text = ""
	
	if Global_Player_Information.character_body_parts[get_part_name(part.body_part_id)] != 0:
		text += "[PART TAKEN]"
	else:
		text += "str: " + str(part.strength) + "\n" 
		text += "def: " + str(part.defense) + "\n" 
		text +=  "agil: " + str(part.agility) + "\n"
		text += "crit chance: "+ str(part.crit_chance) + "\n" 
	label.text = text


func head_selected():
	if Global_Player_Information.character_body_parts["Head"] != 0:
		return

	Global_Player_Information.character_body_parts["Head"] = last_combat
	get_tree().change_scene_to_file("res://Scenes/bedroom.tscn")


func chest_selected():
	if Global_Player_Information.character_body_parts["Torso"] != 0:
		return
	Global_Player_Information.character_body_parts["Torso"] = last_combat
	get_tree().change_scene_to_file("res://Scenes/bedroom.tscn")


func arms_selected():
	if Global_Player_Information.character_body_parts["Left Arm"] != 0:
		return
	Global_Player_Information.character_body_parts["Left Arm"] = last_combat
	Global_Player_Information.character_body_parts["Right Arm"] = last_combat
	get_tree().change_scene_to_file("res://Scenes/bedroom.tscn")

func legs_selected():
	if Global_Player_Information.character_body_parts["Legs"] != 0:
		return
	Global_Player_Information.character_body_parts["Legs"] = last_combat
	get_tree().change_scene_to_file("res://Scenes/bedroom.tscn")



func _process(delta: float) -> void:
	
	pass
