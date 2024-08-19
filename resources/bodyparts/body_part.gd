extends Resource
class_name Body_Part

@export_category("General Info")
@export var name: String = "TBD"
@export_range(0,4,1) var body_part_id: int = 0 #0 torso, 1 head, 2 Larm, 3 Rarm, 4 legs
@export var character_base: int = 0 #0 base, 1 boxer, 2 reddead, 3 robot, 4 sparkstriker
@export_category("Location and Looks")
@export var joint_location: Vector2 = Vector2(0,0)
@export var visible: bool = true
@export_category("Statistics")
@export var strength: int = 0
@export var defense: int = 0
@export var agility: int = 0
@export var crit_change: float = 0.0
@export_category("Special")
