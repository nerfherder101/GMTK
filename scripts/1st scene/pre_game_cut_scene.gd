extends Node

signal dialogue_finished

var resource = load("res://dialogue/intro_banter.dialogue")
var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
@onready var dialogue_label = $DialogueLabel



# Called when the node enters the scene tree for the first time.
func _ready():
	DialogManager.start_dialog(Vector2(360.0, 400.0), ["Hello", "Hi"])
	
	




func _on_dialogue_ended(_resource: DialogueResource):
	# Emit the signal when the dialogue ends
	get_tree().change_scene_to_file("res://Scenes/bedroom.tscn")
	emit_signal("dialogue_finished")
