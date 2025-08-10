# res://Scripts/Player/States/LandState.gd

extends PlayerState

class_name HardLandState

var timer

func enter(_player):
	super.enter(_player)
	
	player.play_animation("land")
	
	timer = get_tree().create_timer(player.hard_land_time) 
	
func process_update(_delta):
	
	await timer.timeout

func physics_update(_delta):
	
	if player.is_on_floor():
		player.jumps = 0;
		
	player.velocity = Vector2.ZERO
	
	player.state_machine.change_state("IdleState")
