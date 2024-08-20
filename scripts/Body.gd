extends Node2D
class_name Body

@export var max_health := 10
@export var health = 10

@export var health_bar : ProgressBar = null
@export var control: PlayerControl = null
@export var battle_screen: Control = null
@export_category("Additional Stats") #THIS IS ONLY TO ADD UPON THE BASE_STATS, ONLY USE IF NEEDED
@export var strength: int = 0
@export var defense: int = 0
@export var agility: int = 0
@export var critical_chance: int = 0
@export var enemey_id = -1


#get resources
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var head_particle = %Head
@onready var torso_particle = %Torso
@onready var arms_particle = %Arms
@onready var legs_particle = %Legs

enum state_anim {idle, attacking, wait, on_hit, explode}
@onready var current_state_anim: int = 0

#audio
@onready var sfx_explode = $Audio/Explode
@onready var sfx_hurt = $Audio/Hurt

func _ready() -> void:
	await get_tree().physics_frame
	health_bar.max_value = max_health
	update_healthbar()

func _process(delta: float) -> void:
	match current_state_anim:
		state_anim.idle:
			animation_player.play("Idle")
			current_state_anim = state_anim.wait
		state_anim.attacking:
			animation_player.animation_set_next("Attack", "Idle")
			animation_player.play("Attack")
			current_state_anim = state_anim.wait
		state_anim.explode:
			current_state_anim = state_anim.wait
			animation_player.clear_queue()
			sprite.hide()
			head_particle.emitting = true
			torso_particle.emitting = true
			arms_particle.emitting = true
			legs_particle.emitting = true
			print("timer initiated")
			await get_tree().create_timer(1.5).timeout
			print("timer passed")
			if get_parent().final_boss:
				battle_screen._fade_to_black_back_to_bedroom()
			else:
				battle_screen._end_battle_player_win()
			
		state_anim.wait:
			pass
	pass

func do_damage(dmg: int):
	var _total_damage = dmg - (get_parent().base_defense + defense)
	if _total_damage < 0:
		_total_damage == 0
	health -= _total_damage
	sfx_hurt.play()
	if health <= 0:
		sfx_explode.play()
		current_state_anim = state_anim.explode
	update_healthbar()

func _do_true_damage(dmg: int):
	health -= dmg
	sfx_hurt.play()
	if health <= 0:
		sfx_explode.play()
		current_state_anim = state_anim.explode
	update_healthbar()

func update_healthbar() -> void:
	health_bar.value = health
	pass

func _animation_finished():
	current_state_anim = state_anim.idle
	get_parent()._animation_finished()


#FOLLOWING FUNCTIONS JUST TO CONTROL SPEECH BUBBLE

#ENEMY BODY
func _missed():
	battle_screen._simple_speech(3, 0, false)

func _successful_attack():
	battle_screen._simple_speech(1, 0, false)
