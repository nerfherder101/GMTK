extends Resource
class_name BaseEnemy

@export var name := "Enemy"
@export var texture: Texture = null
@export var max_health := 100

@export var abilities: Array[Ability] 
