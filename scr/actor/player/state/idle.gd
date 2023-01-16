extends PlayerState

func enter(msg:={}):
	if msg.has('dash'):
		var mouse_coor = plr.global_position.direction_to(plr.get_global_mouse_position())
		plr.motion = mouse_coor * plr.dash_speed
		

func physics_update(delta):
	
	if plr.p_input != Vector2.ZERO:
		state_machine.transition_to("run")
	
	plr.motion = plr.motion.move_toward(Vector2.ZERO,plr.friction)
	plr.move_and_slide(plr.motion)
	
	if Input.is_action_just_pressed("ui_m2"):
		if plr.p_input != Vector2.ZERO:
			state_machine.transition_to('run',{'dash':true})
		else:
			state_machine.transition_to('idle',{'dash':true})
	
	if Input.is_action_just_pressed("ui_m1") and $'%shoot_timer'.is_stopped():
		if plr.p_input != Vector2.ZERO:
			state_machine.transition_to('run',{'shoot':true})
		else:
			state_machine.transition_to('idle',{'shoot':true})
