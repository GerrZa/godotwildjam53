extends PlayerState


func enter(msg:={}):
	
	if msg.has('key'):
		plr.input_left[msg['key']] = true
	
	#Play anim and yield
	
	plr.make_invincible()
	
	if plr.p_input != Vector2.ZERO:
		state_machine.transition_to('run')
	else:
		state_machine.transition_to('idle')
