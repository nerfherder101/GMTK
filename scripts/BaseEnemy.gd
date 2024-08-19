extends Resource
class_name BaseEnemy

@export_category("General Info")
@export var name := "Enemy"
@export var texture: Texture = null
@export var max_health := 10
@export var base_attack_timer: float = 2.0

@export var idle_animation: Animation = null

@export var abilities: Array[Ability] 

@export_category("Special Effects")
@export var vfx: Resource
@export var sfx: Resource
