extends YSort

var player = null

enum WEATHER {NORMAL,HOT,COLD}

var current_weather = WEATHER.NORMAL

var spawn_time_range = [4.5,6]

var dasher = preload("res://scr/actor/enemy/dash_enemy/dash_enemy.tscn")
var bouncer = preload("res://scr/actor/enemy/bounce_enemy/bounce_enemy.tscn")

var transitioner = preload("res://scr/tool/transitioner.tscn")

var input_exist = {
	'left' : true,
	'right' : true,
	'up' : true,
	'down' : true,
	'shoot' : true
}

var kill_count = 0

var enemy_killed = 0

onready var cam = $"%Camera2D"

func _ready():
	
	set_process(false)
	
	$"%AnimationPlayer".play("start")
	
	yield($"%AnimationPlayer","animation_finished")
	
	player.can_control = true
	
	yield(get_tree().create_timer(0.5),"timeout")
	
	randomize()
	
	$"%spawn_timer".start(rand_range(spawn_time_range[0],spawn_time_range[1]))
	
	spawn(3)
	
	set_process(true)

func _process(delta):
	
	$"%kill_counter".text = "kill(s) : " + String(kill_count)
	
	if get_child_count() < 6:
		spawn(3)
	
	if player != null:
		($center_anchor/camera_handler.global_position = 
		$center_anchor.global_position + ((player.global_position - $center_anchor.global_position) * 0.1))

func spawn(amount:=1):
	
	for i in range(amount):
		
		randomize()
		
		var random_number = randi()%2+1
		
		if random_number == 1:
			var bouncer_ins = bouncer.instance()
			
			add_child(bouncer_ins)
		elif random_number == 2:
			var dasher_ins = dasher.instance()
			
			add_child(dasher_ins)

func gameover():
	
	get_tree().paused = true
	
	$CanvasLayer.add_child(transitioner.instance())


func _on_spawn_timer_timeout():
	randomize()
	
	if get_child_count() < 11:
		
		var random_number = randi()%2+1
		
		spawn(random_number)
	
	$"%spawn_timer".start(rand_range(spawn_time_range[0],spawn_time_range[1]))
	
