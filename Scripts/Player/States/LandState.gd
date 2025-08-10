# res://Scripts/Player/States/LandState.gd

extends PlayerState

class_name LandState

var timer: SceneTreeTimer

func enter(_player):
	super.enter(_player)
	
	player.play_animation("land")
	timer = get_tree().create_timer(player.land_run_time)
	timer.timeout.connect(_end, CONNECT_ONE_SHOT)
	
func process_update(_delta):
	pass

func physics_update(_delta):
	
	player.velocity.y = 0.0
	player.velocity.x = move_toward(player.velocity.x, 0.0, player.ground_deacceleration * _delta)
	
func _end():
	if player.is_on_floor(): 
		player.jumps = 0
		player.state_machine.change_state("IdleState")
