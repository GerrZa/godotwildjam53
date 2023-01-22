extends KinematicBody2D


var motion = Vector2.ZERO
var direction = Vector2.ZERO
var speed = 250

var appear_time = 0.5

var is_moving := true

signal take_damage(dir)

var hp = 4

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
	
	direction = global_position.direction_to(get_tree().current_scene.player.global_position).rotated(deg2rad(rand_range(-10,10)))


func _physics_process(delta):
	
	if is_moving:
		
		motion = direction * speed
		
		var obj = move_and_collide(motion * delta)
		if obj:
			randomize()
			
			$"%wallhit_sfx_player".play()
			
			direction = global_position.direction_to(get_tree().current_scene.player.global_position).rotated(deg2rad(rand_range(-5,5)))

func on_take_damage(dir):
	if hp > 1:
		hp -= 1
		
		direction = dir
		
		get_tree().current_scene.cam.shake(4,0.1)
		
		$"%flashing_sprite".visible = true
		
		yield(get_tree().create_timer(0.1),"timeout")
		
		$"%flashing_sprite".visible = false
	
	else:
		get_tree().current_scene.cam.shake(4,0.1)
		
		get_tree().current_scene.kill_count += 1
		
		queue_free()


func _on_hurtbox_body_entered(body):
	if body is Player:
		body.emit_signal("event",'take_damage')
