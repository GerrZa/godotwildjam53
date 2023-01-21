class_name Player
extends KinematicBody2D

var motion = Vector2.ZERO
var p_input = Vector2.ZERO

var speed = 90

var dash_speed = 400
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

var controller = preload("res://scr/obj/controller.tscn")

# Input Strenght
var up_str = 0
var down_str = 0
var right_str = 0
var left_str = 0
signal event(name)

var fire_delay = 0.8
var shoot_shock_time = 0.4
var shoot_knockback_f = 250
var shoot_friction = 20

var shotgun_bullet = preload("res://scr/obj/shotgun_bullet_spawner/shotgun_bullet.tscn")

var invincible = false
var invincible_duration = 1.6

func _ready():
	
	get_tree().current_scene.player = self
	
	for state in $statemachine.get_children():
		connect("event",state,'event_listener')

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal('event','take_damage')
	
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
	
	$invincible_anim.play("blinking")
	
	yield(get_tree().create_timer(invincible_duration),"timeout")
	
	$invincible_anim.play("normal")
	
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
	
	make_invincible()
	
	var controller_ins = controller.instance()
	get_tree().current_scene.add_child(controller_ins)
	controller_ins.global_position = global_position
	controller_ins.key = avaiable_input[0]
	controller_ins.start()
	

func get_input(input_name := 'left'):
	
	emit_signal("event",'get_input')
	
	$statemachine.transition_to('get_input',{'key':input_name})

