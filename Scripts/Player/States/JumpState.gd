# res://Scripts/Player/States/JumpState.gd

extends PlayerState

class_name JumpState

func enter(_player):
	super.enter(_player)
	
	player.velocity.y = player.jump_force
	
	player.play_animation("jump")
	
func process_update(_delta):
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	if direction < 0.0:
		player.sprite.flip_h = true 
	else:
		player.sprite.flip_h = false

func physics_update(_delta):
	
	if Input.is_action_just_pressed("jump") and player.can_jump():
		player.try_to_jump()
		return
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	var target_speed = player.max_speed * direction
	player.velocity.x = move_toward(player.velocity.x, target_speed, player.air_acceleration * _delta)

	# When velocity starts going downward, switch to Fall
	if not player.is_on_floor() and player.velocity.y > 0:
		player.state_machine.change_state("FallState")
		return
