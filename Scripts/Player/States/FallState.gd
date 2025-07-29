# res://Scripts/Player/States/FallState.gd

extends PlayerState

class_name FallState

var fall_time: float = 0.0

func enter(_player):
	super.enter(_player)
	fall_time = 0.0
	player.animation_player.play("fall")

func physics_update(delta):
	fall_time += delta;
	
	player.velocity.y += player.world_gravity * delta
	if player.velocity.y > player.world_terminal_velocity:
		player.velocity.y = player.world_terminal_velocity

	var direction = Input.get_axis("moveLeft", "moveRight")
	player.debug_speed.text = "Speed %s " % str(player.player_max_speed * direction)
	player.velocity.x = player.player_max_speed * direction
	
	if Input.is_action_just_pressed("jump"):
		if player.player_jumps < player.player_max_jumps:
			player.player_jumps += 1
			player.state_machine.change_state("JumpState")
			return

	if player.is_on_floor():
		player.player_jumps = 0;
		
		if fall_time > player.player_hard_land_time:
			player.state_machine.change_state("LandState")
		else:
			player.state_machine.change_state("IdleState")
		return
		
