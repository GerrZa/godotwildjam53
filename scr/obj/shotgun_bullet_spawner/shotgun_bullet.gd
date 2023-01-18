extends Node2D

export var angle_per_bullet := 12
var direction = Vector2.RIGHT

export var bullet_count = 3

var bullet = preload("res://scr/obj/base_bullet.tscn")

var can_destroy := false

func start(shoot_direction):
	
	direction = shoot_direction
	
	var start_angle_direction = angle_per_bullet * floor(bullet_count/2) * -1
	
	for i in range(bullet_count):
		var bullet_ins = bullet.instance()
		
		add_child(bullet_ins)
		bullet_ins.global_position = global_position
		
		bullet_ins.apply_velocity(direction.rotated(deg2rad(start_angle_direction + (angle_per_bullet * i))))
		
	can_destroy = true
	

func _process(delta):
	if get_children().empty() and can_destroy:
		queue_free()
