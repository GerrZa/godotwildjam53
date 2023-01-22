extends State


func enter(msg:={}):
	
	randomize()
	
	owner.global_position.x = rand_range(30,310)
	owner.global_position.y = rand_range(30,225)
	
	$"%appearing_timer".start(owner.appearing_time)
	
	yield($"%appearing_timer","timeout")
	
	owner.appeared = true
	state_machine.transition_to('aim')
