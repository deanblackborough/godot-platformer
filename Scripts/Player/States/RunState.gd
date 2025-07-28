# res://Scripts/Player/States/RunState.gd

extends PlayerState

class_name RunState

func enter(_player):
	super.enter(_player)
	
	if player.player_weapon_drawn == false:
		player.animated_sprite.animation = "Run"
	else:
		player.animated_sprite.animation = "Run-Weapon"

func physics_update(delta):
	if Input.is_action_just_pressed("toggleWeapon"):
		player.player_weapon_drawn = !player.player_weapon_drawn
		if player.player_weapon_drawn == false:
			player.animated_sprite.animation = "Run"
		else:
			player.animated_sprite.animation = "Run-Weapon"
	
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
		
	if player.is_on_floor():
		player.player_jumps = 0
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	player.debug_speed.text = "Speed %s " % str(player.player_max_speed * direction)
	player.velocity.x = player.player_max_speed * direction
	
	if direction == 0:
		player.velocity.x = 0.0
		player.state_machine.change_state("IdleState")
		return
	
	if Input.is_action_just_pressed("jump"):
		if player.player_jumps < player.player_max_jumps:
			player.player_jumps += 1
			player.state_machine.change_state("JumpState")
			return
	
	player.animated_sprite.scale.x = direction if direction != 0 else player.animated_sprite.scale.x
