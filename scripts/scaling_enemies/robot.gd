extends Body

func _ready() -> void:
	match Global_Player_Information.battle_counter:
		1:
			pass
		2:
			health = 7
			strength = 1
		3:
			health = 10
			strength = 1
