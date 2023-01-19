extends PlayerState


func enter(msg:={}):
	
	if msg.has('key'):
		plr.input_left[msg['key']] = true
	else:
		return
	
	if plr.p_input != Vector2.ZERO:
		state_machine.transition_to('run')
	else:
		state_machine.transition_to('idle')
