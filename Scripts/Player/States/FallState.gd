# res://Scripts/Player/States/FallState.gd

extends PlayerState

class_name FallState

var fall_time: float = 0.0

func enter(_player):
	
	super.enter(_player)
	fall_time = 0.0
	
	player.set_collision_shape(player.collision_shapes.STANDING)
	player.play_animation("fall")
	
func process_update(_delta):
	
	fall_time += _delta;

func physics_update(_delta):
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	player.velocity.x = player.apply_acceleration_in_x_in_air(direction, _delta)
	
	if Input.is_action_just_pressed("jump"):
		player.queue_jump()
		return

	if player.is_on_floor():
		if fall_time > player.hard_land_fall_time:
			player.state_machine.change_state("HardLandState")
		else:
			player.state_machine.change_state("LandState")
		return
		
