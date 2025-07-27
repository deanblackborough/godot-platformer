extends PlayerState

func enter(_player):
	super.enter(_player)
	player.animated_sprite.animation = "Run"

func physics_update(delta):
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
		
	if player.is_on_floor():
		player.player_jumps = 0
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	player.velocity.x = player.player_speed * direction
	if direction == 0:
		player.state_machine.change_state("IdleState")
		return
	
	if Input.is_action_just_pressed("jump"):
		if player.player_jumps < player.player_max_jumps:
			player.player_jumps += 1
			player.state_machine.change_state("JumpState")
			return
	
	player.animated_sprite.scale.x = direction if direction != 0 else player.animated_sprite.scale.x
