# res://Scripts/Player/States/JumpState.gd

extends PlayerState

class_name JumpState

func enter(_player):
	super.enter(_player)
	
	player.set_collision_shape(player.collision_shapes.STANDING)
	player.play_animation("jump")
	
func process_update(_delta):
	
	pass

func physics_update(_delta):
	
	if player.jump_pressed:
		player.queue_jump()
		return
	
	var direction = player.direction
	player.velocity.x = player.apply_acceleration_in_x_in_air(direction, _delta)

	# When velocity starts going downward, switch to Fall
	if not player.is_on_floor() and player.velocity.y > 0:
		player.state_machine.change_state("FallState")
		return
