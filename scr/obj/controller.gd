extends KinematicBody2D

var direction = Vector2.ZERO
var motion = Vector2.ZERO

var speed = 300

var pickable = false

var key = 'left'

func _on_player_detect_area_body_exited(body):
	pickable = true

func _on_player_detect_area_body_entered(body):
	if pickable:
		
