extends KinematicBody2D


var player_last_position = Vector2.ZERO
var direction = Vector2.ZERO
var motion = Vector2.ZERO
var friction = 10
var speed = 400
var distance_snap_length = 5

var appearing_time = 0.7

var appeared = false

var aimming_time = 0.75

var hp = 5

signal take_damage(dir)

onready var animtree = $"%AnimationTree".get('parameters/playback')

var sword_sfx = preload("res://asset/sfx/sword_swing.wav")
var dash_sfx = preload("res://asset/sfx/dasher_dash_sfx.wav")

func _ready():
	connect("take_damage",self,'on_take_damage')

func _physics_process(delta):
	
	$"%Icon2".frame = $"%Icon".frame
	
	if motion.x != 0:
		$anchor.scale.x = sign(motion.x)

func on_take_damage(dir):
	
	if appeared:
		
		get_tree().current_scene.cam.shake(4,0.1)
		
		if hp > 1:
			hp -= 1
			
			$"%Icon2".visible = true
			
			yield(get_tree().create_timer(0.1),"timeout")
			
			$"%Icon2".visible = false
		
		else:
			get_tree().current_scene.cam.shake(4,0.1)
			
			get_tree().current_scene.kill_count += 1
			
			queue_free()
