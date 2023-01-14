#BASIC ROOM SCRIPT
extends Node2D

export var left_room_path : NodePath
export var right_room_path : NodePath

var left_room = null
var right_room = null

func _ready():
	if left_room_path != "":
		left_room = get_node(left_room_path)
	else:
		left_room = self
	
	if right_room_path != "":
		right_room = get_node(right_room_path)
	else:
		right_room = self
	
	
