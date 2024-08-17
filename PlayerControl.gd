extends Panel
class_name PlayerControl

@export var buttons: Array[Button] 
@export var abilities: Array[Ability]


func _ready() -> void:
	#connect buttons
	var i = 0
	
	for ab in abilities:
		buttons[i].connect("pressed", Callable(ab, "trigger_ability").bind(get_parent().enemy.body, get_parent().player_body))
		buttons[i].pressed.connect(self.on_select)
		buttons[i].text = ab.name
		i += 1

func toggle_selection() -> void: 
	self.visible = true

func on_select() -> void:
	self.visible = false
	get_parent().player_turn_end()
