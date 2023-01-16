class_name Player
extends KinematicBody2D

var motion = Vector2.ZERO
var p_input = Vector2.ZERO

var speed = 90

var dash_speed = 350
var dash_cd

var acceleration = 20
var friction = 25

var input_left = {
	'up' : true,
	'down' : true,
	'right' : true,
	'left' : true,
	'shoot' : true,
	'dash' : true
}

# Input Strenght
var up_str = 0
var down_str = 0
var right_str = 0
var left_str = 0

var fire_delay = 0.5

func _physics_process(delta):
	
	print(p_input)
	
	if input_left['right']:
		right_str = Input.get_action_strength("ui_right")
	else:
		right_str = 0
	
	if input_left['left']:
		left_str = Input.get_action_strength("ui_left")
	else:
		right_str = 0
	
	if input_left['down']:
		down_str = Input.get_action_strength("ui_down")
	else:
		right_str = 0
	
	if input_left['up']:
		up_str = Input.get_action_strength("ui_up")
	else:
		right_str = 0
	
	p_input.x = right_str - left_str
	p_input.y = down_str - up_str
	
	p_input = p_input.normalized()














