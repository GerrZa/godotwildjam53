extends Node2D

var fan_active := false
var firewood_active := false

export var init_room = NodePath()

var current_room = null
var can_move_room := true


var max_time = 15
var current_time = max_time

#Timer decreaser for multiplying delta
var fan_de = 0.35
var firewood_de = 0.15

var point = 0

func _ready():
	current_room = get_node(init_room)

func _process(delta):
	$Camera2D.global_position = current_room.global_position
	
	if Input.is_action_just_pressed("ui_left"):
		move_room(Vector2.LEFT)
	elif Input.is_action_just_pressed("ui_right"):
		move_room(Vector2.RIGHT)

func _physics_process(delta):
	
	print(current_time)
	
	if fan_active == false and firewood_active == false:
		current_time -= delta
	elif fan_active == true and firewood_active == false:
		current_time -= delta + (delta * fan_de)
	elif fan_active == false and firewood_active == true:
		current_time -= delta + (delta * firewood_de)
	elif fan_active == true and firewood_active == true:
		current_time -= delta + (delta * fan_de) + (delta * firewood_de)

func move_room(direction : Vector2):
	
	match direction:
		Vector2.RIGHT:
			if current_room.right_room != null:
				current_room = current_room.right_room
		Vector2.LEFT:
			if current_room.left_room != null:
				current_room = current_room.left_room
