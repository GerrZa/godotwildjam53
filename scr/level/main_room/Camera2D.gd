extends Camera2D

var strength = 5

func _ready():
	set_process(false)

func _process(delta):
	randomize()
	
	offset = Vector2(rand_range(-strength,strength),rand_range(-strength,strength))

func shake(shake_force, shake_time):
	
	$Timer.stop()
	
	strength = shake_force
	
	set_process(true)
	
	$Timer.start(shake_time)
	yield($Timer,"timeout")
	
	set_process(false)
