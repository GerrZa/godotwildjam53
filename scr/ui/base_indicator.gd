extends Node2D

export var input_name := "left"

func _process(delta):
	
	if get_tree().current_scene.input_exist[input_name]:
		if get_tree().current_scene.player.input_left[input_name]:
			$frame.visible = false
			$normal.visible = true
			$cross.visible = false
		else:
			$frame.visible = true
			$normal.visible = false
			$cross.visible = false
		
	else:
		$frame.visible = true
		$normal.visible = false
		$cross.visible = true
