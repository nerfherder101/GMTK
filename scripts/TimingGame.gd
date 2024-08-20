extends TextureRect
class_name TimingGame


signal timing_game_ended(result)

@export var pointer: TextureRect = null
@export var ptr_speed: int = 10
@export var success_zone: TextureRect = null
@export var success_size: int = 100
@export var attempt_button: Button = null
@export var result_label: Label = null

var forward = true
var x_min = 0
var x_max = 0

var running = false

func _ready () -> void:
	attempt_button.pressed.connect(attempt)

func start_game(speed: int, success_sz: int):
	ptr_speed = speed
	success_size = success_sz
	
	get_parent().visible = true
	result_label.text = ""
	
	x_max = self.size.x - pointer.size.x
	pointer.position = Vector2(0, 0)
	
	success_zone.size = Vector2(success_size, success_zone.size.y)
	success_zone.position = Vector2(self.size.x / 2 - success_zone.size.x / 2, 0)
	
	running = true

func attempt(): 
	running = false
	var success = get_success()
	if success:
		result_label.text = "GOOD JOB!"
	else:
		result_label.text = "YOU SUCK!"
	
	emit_signal("timing_game_ended", success)
	await get_tree().create_timer(1).timeout
	get_parent().visible = false



func get_success() -> bool:
	return pointer.position.x < success_zone.position.x + success_zone.size.x and pointer.position.x > success_zone.position.x

func _physics_process(delta: float) -> void:
	if running:
		if forward:
			pointer.position += Vector2(ptr_speed, 0)
			if pointer.position.x > x_max:
				pointer.position = Vector2(x_max, pointer.position.y)
				forward = false
		else:
			pointer.position += Vector2(-ptr_speed, 0)
			if pointer.position.x < x_min:
				pointer.position = Vector2(x_min, pointer.position.y)
				forward = true
