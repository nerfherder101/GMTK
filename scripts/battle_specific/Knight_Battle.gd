extends Battle_Screen

@onready var eye_1 = %Eye
@onready var eye_2 = %Eye_2
@onready var eye_3 = %Eye_3
@onready var lid_b = %Lid_bottom
@onready var lid_t = %Lid_top

@onready var rng = RandomNumberGenerator.new()

var max_time_eye: float
var max_time_blink: float
var timer_for_next_eye_movement: float
var timer_for_next_blink: float

var blink_transition: bool = false
var eye_transition: bool = false

func _ready() -> void:
	max_time_eye = rng.randf_range(2, 5)
	max_time_blink = rng.randf_range(4,6)
	timer_for_next_eye_movement = max_time_eye
	timer_for_next_blink = max_time_blink

func _physics_process(delta: float) -> void:
	timer_for_next_blink -= delta
	timer_for_next_eye_movement -= delta
	if timer_for_next_blink < 0:
		_make_eye_blink()
		timer_for_next_blink = rng.randf_range(4,6)
	if timer_for_next_eye_movement < 0:
		var _case: int = rng.randi_range(0,2)
		match _case:
			0:
				_look_forward()
			1:
				_look_at_player()
			2:
				_look_at_enemy()
		timer_for_next_eye_movement = rng.randf_range(4,6)

func _make_eye_blink():
	if blink_transition:
		return
	blink_transition = true
	lid_t.position = Vector2(171, -255)
	lid_b.position = Vector2(-97, 213)
	lid_t.show()
	lid_b.show()
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN)
	_tween.set_trans(Tween.TRANS_EXPO)
	_tween.set_parallel(true)
	_tween.tween_property(lid_t,"position",Vector2(0,0),0.2).from_current()
	_tween.tween_property(lid_b,"position",Vector2(0,0),0.2).from_current()
	await _tween.finished
	await get_tree().create_timer(0.1).timeout
	var _tween2 = create_tween()
	_tween2.set_ease(Tween.EASE_IN_OUT)
	_tween2.set_trans(Tween.TRANS_EXPO)
	_tween2.set_parallel(true)
	_tween2.tween_property(lid_t,"position",Vector2(171, -255),0.4).from_current()
	_tween2.tween_property(lid_b,"position",Vector2(-97, 213),0.4).from_current()
	await _tween2.finished
	blink_transition = false
	lid_t.hide()
	lid_b.hide()

func _look_forward():
	if eye_transition:
		return
	eye_transition = true
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN)
	_tween.set_trans(Tween.TRANS_EXPO)
	_tween.set_parallel(true)
	_tween.tween_property(eye_2,"position",Vector2(841,111),0.4).from_current()
	_tween.tween_property(eye_3,"position",Vector2(880,141),0.4).from_current()
	await _tween.finished
	eye_transition = false

func _look_at_player():
	if eye_transition:
		return
	eye_transition = true
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_EXPO)
	_tween.set_parallel(true)
	_tween.tween_property(eye_2,"position",Vector2(743,168),0.4).from_current()
	_tween.tween_property(eye_3,"position",Vector2(760,220),0.4).from_current()
	await _tween.finished
	eye_transition = false

func _look_at_enemy():
	if eye_transition:
		return
	eye_transition = true
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_EXPO)
	_tween.set_parallel(true)
	_tween.tween_property(eye_2,"position",Vector2(987,171),0.4).from_current()
	_tween.tween_property(eye_3,"position",Vector2(1050,241),0.4).from_current()
	await _tween.finished
	eye_transition = false
