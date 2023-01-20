extends State

func enter(msg:={}):
	
	owner.motion = owner.global_position.direction_to(owner.player_last_position) * owner.speed

func physics_update(delta):
	
	owner.motion = owner.move_and_slide(owner.motion)
	
	if owner.global_position.distance_to(owner.player_last_position) <= owner.distance_snap_length:
		
		owner.global_position = owner.player_last_position
		
		state_machine.transition_to('slowdown')
