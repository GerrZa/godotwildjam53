extends KinematicBody2D

var direction = Vector2.ZERO
var motion = Vector2.ZERO

var speed = 100

var pickable = false

var key = 'left'

func _ready():
	  start()

func start():
	randomize()
	
	direction = Vector2.RIGHT.rotated(deg2rad(rand_range(0,360)))

func _physics_process(delta):
	
	motion = direction * speed
	
	var obj = move_and_collide(motion * delta)
	if obj:
		direction = obj.normal.rotated(deg2rad(rand_range(-60,60)))

func _on_player_detect_area_body_exited(body):
	pickable = true

func _on_player_detect_area_body_entered(body):
	if pickable:
		body.get_input(key)
		
		#play anim
		
		queue_free()
