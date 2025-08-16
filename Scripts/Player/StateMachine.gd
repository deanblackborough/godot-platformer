# res://Scripts/Player/StateMachine.gd

extends Node

class_name StateMachine

var player = Player

var states = {}

var current_state: PlayerState

func _ready():
	player = get_parent() as Player
	assert(player != null, "StateMachine Node must be a child of Player")
	
	for child in get_children():
		states[child.name] = child

func change_state(new_state_name: String):
	if current_state and current_state.name == str(new_state_name):
		return
	
	if current_state:
		current_state.exit()
		
	if states.has(new_state_name):
		current_state = states[new_state_name]
		player.debug_state.text = "State: %s" % new_state_name
		current_state.enter(player)
	else:
		print_debug('State: %s does not exist' % new_state_name)
		
func process_update(delta: float):
	if current_state:
		current_state.process_update(delta)

func physics_update(delta: float):
	if current_state:
		current_state.physics_update(delta)
		
