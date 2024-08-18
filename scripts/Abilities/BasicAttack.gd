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
		
