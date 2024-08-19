extends Resource
class_name BaseEnemy

@export_category("General Info")
@export var name := "Enemy"
@export var texture: Texture = null
@export var base_health := 10
@export var base_attack_timer: float = 2.0
@export var base_strength: int = 1
@export var base_defense: int = 1

@export var idle_animation: Animation = null

@export var abilities: Array[Ability] 

@export_category("Special Effects")
@export var vfx: Resource
@export var sfx: Resource
