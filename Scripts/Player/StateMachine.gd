# res://Scripts/Player/StateMachine.gd

extends Node

class_name StateMachine

var states = {}

var current_state: PlayerState

func _ready():
	for child in get_children():
		states[child.name] = child

func change_state(new_state_name: String):
	if current_state:
		current_state.exit()
	current_state = states[new_state_name]
	owner.debug_state.text = "State: %s" % new_state_name
	current_state.enter(owner)
	
func input_update(event: InputEvent):
	if current_state:
		current_state.input_update(event)
		
func process_update(delta: float):
	if current_state:
		current_state.process_update(delta)

func physics_update(delta: float):
	if current_state:
		current_state.physics_update(delta)
		
