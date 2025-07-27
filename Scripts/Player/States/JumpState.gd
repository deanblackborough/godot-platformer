# res://Scripts/Player/States/JumpState.gd

extends PlayerState

class_name JumpState

func enter(_player):
	super.enter(_player)
	# Reset vertical velocity and apply jump force
	player.velocity.y = player.player_jump_force
	player.animated_sprite.animation = "Jump"

func physics_update(delta):
	# Apply horizontal input
	var direction = Input.get_axis("moveLeft", "moveRight")
	player.velocity.x = player.player_speed * direction

	# Apply gravity
	player.velocity.y += player.world_gravity * delta

	# When velocity starts going downward, switch to Fall
	if player.velocity.y > 0:
		player.state_machine.change_state("FallState")
		return
		
	if Input.is_action_just_pressed("jump"):
		if player.player_jumps < player.player_max_jumps:
			player.player_jumps += 1
			player.state_machine.change_state("JumpState")
			return
