extends Ability

func trigger_ability(target:Body, user:Body):
	timing_mg.start_game(10, 100)
	await timing_mg.timing_game_ended
	var success = timing_mg.get_success()
	var dmg = 1
	if not success:
		dmg += 1
	
	target.do_damage(dmg)
	emit_signal("ability_complete")
		

func _trigger_ability_2(target:Body, user:Body):
	var dmg = 2
	if target.control.parrying:
		dmg -= 1
	target.do_damage(dmg)
	emit_signal("ability_complete")
