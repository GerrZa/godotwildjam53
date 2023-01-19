extends State

func enter(msg:={}):
	
	$"%aimming_time".start(owner.aimming_time)
	yield($"%aimming_time","timeout")
	
	state_machine.transition_to('dash')
	

func physics_update(delta):
	
	owner.last_player_position = get_tree().current_scene.player.global_position
	
	
	
