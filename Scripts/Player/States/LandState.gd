# res://Scripts/Player/States/LandState.gd

extends PlayerState

class_name LandState

var timer

func enter(_player):
	super.enter(_player)
	
	player.play_animation("land")
	
	timer = get_tree().create_timer(player.land_run_time) 
	
func process_update(_delta):
	
	await timer.timeout
	
	if player.is_on_floor():
		player.jumps = 0;
		
	player.state_machine.change_state("IdleState")

func physics_update(_delta):
	
	player.velocity = Vector2.ZERO
	
