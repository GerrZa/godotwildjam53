class_name Player
extends KinematicBody2D

var motion = Vector2.ZERO
var p_input = Vector2.ZERO

var speed = 90

var dash_speed = 350
var dash_cd = 0.75

var acceleration = 20
var friction = 25

var input_left = {
	'up' : true,
	'down' : true,
	'right' : true,
	'left' : true,
	'shoot' : true,
}

# Input Strenght
var up_str = 0
var down_str = 0
var right_str = 0
var left_str = 0
signal event(name)
var fire_delay = 0.5

var invincible = false
var invincible_duration = 1.6

func _ready():
	
	for state in $statemachine.get_children():
		connect("event",state,'event_listener')

func _physics_process(delta):
	
	print(
		String(input_left['up']) + String(input_left['down']) + String(input_left['right']) + String(input_left['left']) + String(input_left['shoot'])
	)
	
	if input_left['right']:
		right_str = Input.get_action_strength("ui_right")
	else:
		right_str = 0
	
	if input_left['left']:
		left_str = Input.get_action_strength("ui_left")
	else:
		left_str = 0
	
	if input_left['down']:
		down_str = Input.get_action_strength("ui_down")
	else:
		down_str = 0
	
	if input_left['up']:
		up_str = Input.get_action_strength("ui_up")
	else:
		up_str = 0
	
	p_input.x = right_str - left_str
	p_input.y = down_str - up_str
	
	p_input = p_input.normalized()

func make_invincible():
	invincible = true
	
	# Play anim
	
	yield(get_tree().create_timer(invincible_duration),"timeout")
	
	#Stop anim
	
	invincible = false

func take_damage():
	
	#Check available input
	var avaiable_input = []
	for key in input_left:
		if input_left[key]:
			avaiable_input.append(key)
	
	#In case no input left player dies
	if avaiable_input.empty() == true:
		emit_signal("event","ded")
		
		return
	
	randomize()
	
	avaiable_input.shuffle()
	input_left[avaiable_input[0]] = false
	
	
func get_input(input_name := 'left'):
	
	emit_signal("event",'get_input')
	
	$statemachine.transition_to('')

