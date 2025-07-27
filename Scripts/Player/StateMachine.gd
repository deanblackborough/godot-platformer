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
	print("Entering state " + new_state_name)
	current_state.enter(owner)

func physics_update(delta: float):
	if current_state:
		current_state.physics_update(delta)
