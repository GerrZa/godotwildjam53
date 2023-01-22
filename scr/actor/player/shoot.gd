extends PlayerState

var state_finished := false

func enter(msg:={}):
	
	var shotgun_bullet_ins = plr.shotgun_bullet.instance()
	
	$"%shoot_timer".start(plr.fire_delay)
	
	var mouse_coor = plr.global_position.direction_to(plr.get_global_mouse_position())
	
	get_tree().current_scene.add_child(shotgun_bullet_ins)
	shotgun_bullet_ins.global_position = $"%particle".global_position
	shotgun_bullet_ins.start(mouse_coor)
	
	plr.motion = mouse_coor * -1 * plr.shoot_knockback_f
	
	$"%shoot_sfx_player".play()
	
	$"%particle_animplayer".play("shoot")
	get_tree().current_scene.cam.shake(2,0.1)
	
	state_finished = true

func physics_update(delta):
	
	plr.motion = plr.move_and_slide(plr.motion)
	
	plr.motion = plr.motion.move_toward(Vector2.ZERO,plr.shoot_friction)
	
	if state_finished and plr.motion == Vector2.ZERO:
		
		
		if plr.p_input != Vector2.ZERO:
			state_machine.transition_to('run')
		else:
			state_machine.transition_to('idle')

func exit():
	state_finished = false
