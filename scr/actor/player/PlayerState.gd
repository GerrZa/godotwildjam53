class_name PlayerState
extends State

var plr : Player = null

func _ready():
	
	yield(owner,"ready")
	plr = owner
	assert(plr != null)
