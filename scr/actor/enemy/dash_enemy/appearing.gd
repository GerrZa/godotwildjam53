extends State


func enter(msg:={}):
	
	$"%appearing_timer".start(owner.appearing_time)
	
	yield($"%appearing_timer","timeout")
	
	state_machine.transition_to('aim')
