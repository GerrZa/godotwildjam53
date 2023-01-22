extends State

func enter(msg:={}):
	
	$"%aimming_timer".start(owner.aimming_time)
	owner.animtree.travel('idle')
	
	yield($"%aimming_timer","timeout")
	
	state_machine.transition_to('dash')
	

func physics_update(delta):
	
	owner.player_last_position = get_tree().current_scene.player.global_position
	
