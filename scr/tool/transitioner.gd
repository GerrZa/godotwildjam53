extends ColorRect

func _ready():
	
	modulate = Color(1,1,1,0)
	
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self,'modulate',Color(1,1,1,1),1)
	
	yield(tween,"finished")
	
	get_tree().paused = false
	get_tree().change_scene("res://scr/level/gameover.tscn")
