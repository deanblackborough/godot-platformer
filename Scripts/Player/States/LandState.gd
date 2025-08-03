# res://Scripts/Player/States/LandState.gd

extends PlayerState

class_name LandState

var timer

func enter(_player):
	super.enter(_player)
	player.play_animation("land")
	timer = get_tree().create_timer(0.4) 
	
func process_update(delta):
	await timer.timeout
	player.state_machine.change_state("IdleState")

func physics_update(delta):
	player.velocity = Vector2.ZERO
