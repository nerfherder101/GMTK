extends Node

signal dialogue_finished
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/intro_banter.dialogue"), "start")
		return

func _on_dialogue_ended(_resource: DialogueResource):
	# Emit the signal when the dialogue ends
	get_tree().change_scene_to_file("res://Scenes/bedroom.tscn")
	emit_signal("dialogue_finished")
