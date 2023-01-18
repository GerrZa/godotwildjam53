extends YSort

var player = null

func _process(delta):
	
	if player != null:
		($center_anchor/camera_handler.global_position = 
		$center_anchor.global_position + ((player.global_position - $center_anchor.global_position) * 0.1))
