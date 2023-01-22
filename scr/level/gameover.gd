extends Node2D


func _process(delta):
	
	if Input.is_action_just_pressed("ui_space"):
		get_tree().change_scene("res://scr/level/main_room/level1.tscn")
