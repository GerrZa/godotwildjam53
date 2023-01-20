extends State


func physics_update(delta):
	
	owner.motion = owner.motion.move_toward(Vector2.ZERO,35)
	owner.motion = owner.move_and_slide(owner.motion)
	
	print(owner.motion)
	
	if owner.motion == Vector2.ZERO:
		state_machine.transition_to('aim')
