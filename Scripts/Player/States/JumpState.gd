# res://Scripts/Player/States/JumpState.gd

extends PlayerState

class_name JumpState

func enter(_player):
	super.enter(_player)
	player.velocity.y = player.player_jump_force
	player.play_animation("jump")
	
func process_update(delta):
	var direction = Input.get_axis("moveLeft", "moveRight")
	player.debug_speed.text = "Speed %s " % str(player.player_max_speed * direction)
	player.velocity.x = player.player_max_speed * direction
	
	if Input.is_action_just_pressed("jump"):
		if player.player_jumps < player.player_max_jumps:
			player.player_jumps += 1
			player.state_machine.change_state("JumpState")
			return

func physics_update(delta):

	# Apply gravity
	player.velocity.y += player.world_gravity * delta

	# When velocity starts going downward, switch to Fall
	if not player.is_on_floor() and player.velocity.y > 0:
		player.state_machine.change_state("FallState")
		return
