extends YSort

var player = null

enum WEATHER {NORMAL,HOT,COLD}

var current_weather = WEATHER.NORMAL

var spawn_time_range = [2,3.5]

var dasher = preload("res://scr/actor/enemy/dash_enemy/dash_enemy.tscn")
var bouncer = preload("res://scr/actor/enemy/bounce_enemy/bounce_enemy.tscn")
var shooter 

func _ready():
	randomize()
	
	$"%spawn_timer".start(rand_range(spawn_time_range[0],spawn_time_range[1]))

func _process(delta):
	
	if player != null:
		($center_anchor/camera_handler.global_position = 
		$center_anchor.global_position + ((player.global_position - $center_anchor.global_position) * 0.1))

func spawn(amount:=1,random:= false,enemy_name:='none'):
	
	if random:
		for i in range(amount):
			
			var random_number = randi()%3+1
			
			if random_number == 1:
				var bouncer_ins = bouncer.instance()
				
				get_tree().current_scene.add_child(bouncer_ins)
			elif random_number == 2:
				var dasher_ins = dasher.instance()
				
				get_tree().current_scene.add_child(dasher_ins)
			elif random_number == 3:
				var shooter_ins = shooter.instance()
				
				get_tree().current_scene.add_child(shooter_ins)
