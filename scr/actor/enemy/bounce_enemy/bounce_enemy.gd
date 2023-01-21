extends KinematicBody2D


var motion = Vector2.ZERO
var direction = Vector2.ZERO
var speed = 300

var appear_time = 2.45

var is_moving := true

signal take_damage(dir)

var hp = 3

func _ready():
	
	$CollisionShape2D.disabled = true
	$hurtbox/CollisionShape2D.disabled = true
	
	connect("take_damage",self,'on_take_damage')
	
	randomize()
	
	global_position.x = rand_range(30,310)
	global_position.y = rand_range(30,225)
	
	$"%appear_timer".start(appear_time)
	yield($"%appear_timer","timeout")
	
	$CollisionShape2D.disabled = false
	$hurtbox/CollisionShape2D.disabled = false
	
	direction = Vector2.RIGHT.rotated(deg2rad(rand_range(0,360)))


func _physics_process(delta):
	
	if is_moving:
		
		motion = direction * speed
		
		var obj = move_and_collide(motion * delta)
		if obj:
			randomize()
			
			direction = obj.normal.rotated(deg2rad(rand_range(-60,60)))

func on_take_damage(dir):
	if hp > 1:
		hp -= 1
		
		direction = dir
	else:
		queue_free()


func _on_hurtbox_body_entered(body):
	if body is Player:
		body.emit_signal("event",'take_damage')
