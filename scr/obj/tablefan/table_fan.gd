extends Node2D

var active := false

func _process(delta):
	get_tree().current_scene.fan_active = active
	
	match active:
		true:
			$fan_sprite.frame = 1
		false:
			$fan_sprite.frame = 0

func _on_click_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			active = !active
