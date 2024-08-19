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
		

func _trigger_ability_2(target:Body, user:Body, base_stats: BaseEnemy):
	var dmg = (base_stats.base_strength + user.strength) - target.defense #FORMULA TO CALCULATE THE DAMAGE THE PLAYER WILL RECEIVE: BASE STRENGTH OF THE PROFILE + ANY ADDITIONAL STRENGTH - THE PLAYER'S DEFENSE
	if target.control.parrying:
		dmg -= 1
		target._success_parry() #JUST TO CONTROL SPEECH BUBBLES
		user._missed()
	else:
		target._not_parry() #JUST TO CONTROL SPEECH BUBBLES
		if base_stats.vfx != null:
			target.add_child(base_stats.vfx.instantiate())
		user._successful_attack()
	target.do_damage(dmg)
	emit_signal("ability_complete")
