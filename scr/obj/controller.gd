extends KinematicBody2D

var direction = Vector2.ZERO
var motion = Vector2.ZERO

var speed = 85

var pickable = false

var key = 'left'

var lasting_time = 3

func start():
	
	
	play_anim()
	
	$"%lasting_timer".start(lasting_time)
	
	randomize()
	
	direction = Vector2.RIGHT.rotated(deg2rad(rand_range(0,360)))

func _physics_process(delta):
	
	motion = direction * speed
	
	var obj = move_and_collide(motion * delta)
	if obj:
		randomize()
		
		direction = obj.normal.rotated(deg2rad(rand_range(-60,60)))
	
	$Polygon2D3/lasting_indicator.scale.x = $"%lasting_timer".time_left / lasting_time

func play_anim():
	
	$"%AnimationPlayer".play('jump_out_' + key)
	
	yield($"%AnimationPlayer","animation_finished")
	
	pickable = true
	
	$"%AnimationPlayer".play("run_" + key)

func _on_player_detect_area_body_entered(body):
	if pickable:
		body.get_input(key)
		
		queue_free()



func _on_lasting_timer_timeout():
	ded()

func ded():
	get_tree().current_scene.input_exist[key] = false
	
	queue_free()
