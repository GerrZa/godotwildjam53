# PLAYER's bullet 
extends Area2D

var can_disappear = false
var velocity = Vector2.ZERO

var lasting_time = 0.02

var speed = 600

func _physics_process(delta):
	
	look_at(global_position + velocity.normalized())
	
	global_position += velocity * delta
	
	if get_overlapping_bodies().empty() == false:
		if get_overlapping_bodies()[0] is KinematicBody2D:
			get_overlapping_bodies()[0].emit_signal('take_damage',global_position.direction_to(get_overlapping_bodies()[0].global_position))
		elif get_overlapping_bodies()[0] is StaticBody2D:
			pass
		queue_free()
	
	if $Bullet.modulate == Color(1,1,1,0):
		queue_free()
	

func slow_down():
	
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self,'velocity',Vector2.ZERO,0.15)
	
	yield(get_tree().create_timer(0.05),"timeout")
	
	$CollisionShape2D.disabled
	
	var tween2 = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween2.tween_property($Bullet,'modulate',Color(1,1,1,0),0.2)
	

func apply_velocity(direction : Vector2):
	velocity = direction * speed
	
	$"%lasting_timer".start(lasting_time)
	yield($"%lasting_timer","timeout")
	
	can_disappear = true
	
	slow_down()
extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
