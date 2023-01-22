extends Sprite


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta):
	if get_tree().current_scene.player.can_shoot:
		modulate = Color(1,1,1,1)
	else:
		modulate = Color(1,1,1,0.3)
	
	global_position = get_global_mouse_position()

func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
