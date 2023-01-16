class_name StateMachine
extends Node

export var init_state = NodePath()

onready var state : State = get_node(init_state)
var previous_state : State = null

signal transitioned(state_name)

func _ready():
	yield(owner,"ready")
	for node in get_children():
		node.state_machine = self
	
	state.enter()

func _process(delta):
	state.update(delta)

func _physics_process(delta):
	state.physics_update(delta)

func _unhandled_input(event):
	state.unhandled_input(event)

func transition_to(statename:String,msg:={}):
	
	if not has_node(statename):
		return
	
	state.exit()
	previous_state = state
	state = get_node(statename)
	state.enter(msg)
	
	emit_signal("transitioned",state.name)
