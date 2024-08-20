extends Body

func _ready() -> void:
	match Global_Player_Information.battle_counter:
		1:
			pass
		2:
			health = 8
			defense = 0
			strength = 1
		3:
			health = 10
			defense = 0
			strength = 2
