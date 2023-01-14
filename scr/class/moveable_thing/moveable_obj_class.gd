class_name MoveableObj
extends Area2D

var selected := false
var can_select := true

signal clicked

var mouse_pos = Vector2.ZERO
var mouse_addition_distance = Vector2.ZERO

func _ready():
	connect("input_event",self,"on_input_event")

func _process(delta):
	if selected and can_select:
		follow_mouse()

func follow_mouse():
	mouse_pos = get_global_mouse_position()
	
	global_position = mouse_pos + (mouse_addition_distance * -1)
	

func on_input_event(viewport,event,shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			emit_signal("clicked")
			mouse_addition_distance = get_global_mouse_position() - global_position
			selected = true
		else:
			selected = false
	

func stop_select():
	can_select = false
	selected = false
