extends PlayerState

func enter(msg:={}):
	
	if msg.has('dash'):
		var mouse_coor = plr.global_position.direction_to(plr.get_global_mouse_position())
		plr.motion = mouse_coor * plr.dash_speed
		
		$"%dash_sfx_player".play()
		
		$"%dash_timer".start(plr.dash_cd)
	

func physics_update(delta):
	
	if plr.p_input == Vector2.ZERO:
		state_machine.transition_to('idle')
	
	if sign(plr.motion.x) == sign(plr.global_position.direction_to(plr.get_global_mouse_position()).x):
		$"%AnimationPlayer".play("run")
	elif sign(plr.motion.x) != sign(plr.global_position.direction_to(plr.get_global_mouse_position()).x):
		$"%AnimationPlayer".play("run_reverse")
	
	plr.motion = plr.motion.move_toward(plr.p_input * plr.speed,plr.acceleration)
	plr.motion = plr.move_and_slide(plr.motion)
	
	if Input.is_action_just_pressed("ui_m2") and $"%dash_timer".is_stopped():
		if plr.p_input != Vector2.ZERO:
			state_machine.transition_to('run',{'dash':true})
		else:
			state_machine.transition_to('idle',{'dash':true})
	
	if Input.is_action_just_pressed("ui_m1") and $'%shoot_timer'.is_stopped() and plr.input_left['shoot']:
		state_machine.transition_to('shoot')

func event_listener(event):
	
	match event:
		'take_damage':
			if state_machine.state == self and plr.invincible == false:
				plr.take_damage()

