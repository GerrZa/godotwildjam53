extends State

func enter(msg:={}):
	
	randomize()
	
	owner.motion = owner.global_position.direction_to(owner.player_last_position).rotated(deg2rad(rand_range(-3,3))) * owner.speed
	
	owner.animtree.travel('dash')
	

func physics_update(delta):
	
	
	var obj = owner.move_and_collide(owner.motion * delta)
	if obj:
		
		$"%sfx_player".stop()
		$"%sfx_player".stream = owner.sword_sfx
		$"%sfx_player".play()
		
		state_machine.transition_to('aim')
	
	if owner.global_position.distance_to(owner.player_last_position + owner.global_position.direction_to(owner.player_last_position)) <= owner.distance_snap_length:
		
		owner.global_position = owner.player_last_position
		
		$"%sfx_player".stop()
		$"%sfx_player".stream = owner.sword_sfx
		$"%sfx_player".play()
		
		state_machine.transition_to('slowdown')
	
	
	if $"%hurtbox".get_overlapping_bodies().empty() == false and $"%hurtbox".get_overlapping_bodies()[0] is Player:
		
		$"%hurtbox".get_overlapping_bodies()[0].emit_signal('event','take_damage')
		
		$"%sfx_player".stop()
		$"%sfx_player".stream = owner.sword_sfx
		$"%sfx_player".play()
		
		state_machine.transition_to('slowdown')
		
