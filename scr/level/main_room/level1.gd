extends YSort

var player = null

enum WEATHER {NORMAL,HOT,COLD}

var current_weather = WEATHER.NORMAL

func _process(delta):
	
	if player != null:
		($center_anchor/camera_handler.global_position = 
		$center_anchor.global_position + ((player.global_position - $center_anchor.global_position) * 0.1))
