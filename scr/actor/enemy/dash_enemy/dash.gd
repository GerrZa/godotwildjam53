extends State


func _physics_process(delta):
	
	owner.motion = owner.global_position.direction_to(owner.player_last_position.global_positon) * owner.speed
	
	owner.motion = owner.move_and_slide(owner.motion)
	
	if owner.global_positon.distance_to(owner.player_last_position.global_positon) >= 650:
		
		owner.global_position = owner.player_last_position
		
		state_machine.transition('slowdown')
