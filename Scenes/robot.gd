extends Sprite2D

var mouse_in = false
var hover_character = preload("res://art/character art/SentryFlashStillOutline.webp")
var regular_character = preload("res://art/character art/SentryFlashStill.png")

func _ready():
	if Global_Player_Information.characters_available["Sentry Flash"] == false:
		hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and mouse_in:
		if get_rect().has_point(to_local(event.position)):
			get_tree().change_scene_to_file("res://battle scenes/RobotBattle.tscn")
			
func _on_area_2d_mouse_entered():
	mouse_in = true
	texture = hover_character


func _on_area_2d_mouse_exited():
	mouse_in = false
	texture = regular_character
