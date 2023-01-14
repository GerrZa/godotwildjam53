extends Node2D

var active := false

func _process(delta):
	get_tree().current_scene.firewood_active = active
	
	match active:
		true:
			$wood_sprite.frame = 1
		false:
			$wood_sprite.frame = 0

func _on_click_area2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			active = !active
