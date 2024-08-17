extends Ability

func trigger_ability(target: Body, user: Body):
	user.do_damage(-10)
