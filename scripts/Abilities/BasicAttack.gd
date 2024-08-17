extends Ability

func trigger_ability(target:Body, user:Body):
	target.do_damage(10)
