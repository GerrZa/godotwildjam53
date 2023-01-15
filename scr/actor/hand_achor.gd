extends Node2D


func _process(delta):
	look_at(get_global_mouse_position())
	
	if global_position.direction_to(get_global_mouse_position()).x < 0:
		$GunHand.flip_v = true
	else:
		$GunHand.flip_v = false
