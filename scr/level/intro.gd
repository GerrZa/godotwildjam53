extends Node2D


var can_start = false

func _ready():
	
	$AnimationPlayer.play("start")
	yield($AnimationPlayer,"animation_finished")
	
	can_start = true

func _process(delta):
	
	if Input.is_action_just_pressed("ui_space") and can_start:
		can_start = false
		
		$AnimationPlayer.play("change")
		yield($AnimationPlayer,"animation_finished")
		
		get_tree().change_scene("res://scr/level/main_room/level1.tscn")
