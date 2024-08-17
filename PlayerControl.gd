extends Panel
class_name PlayerControl

@export var buttons: Array[Button] 
@export var abilities: Array[Ability]


func _ready() -> void:
	#connect buttons
	var i = 0
	for ab in abilities:
		ab.target = get_parent().enemy.body
		buttons[i].pressed.connect(ab.trigger_ability)
		buttons[i].pressed.connect(self.on_select)
		buttons[i].text = ab.name

func toggle_selection() -> void: 
	self.visible = true

func on_select() -> void:
	self.visible = false
	get_parent().player_turn_end()
