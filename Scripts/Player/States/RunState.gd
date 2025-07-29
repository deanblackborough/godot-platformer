# res://Scripts/Player/States/RunState.gd

extends PlayerState

class_name RunState

func enter(_player):
	super.enter(_player)
	
	if player.player_weapon_drawn == false:
		player.animation_player.play("run")
	else:
		player.animation_player.play("run-weapon")

func physics_update(delta):
	if Input.is_action_just_pressed("toggleWeapon"):
		player.player_weapon_drawn = !player.player_weapon_drawn
		if player.player_weapon_drawn == false:
			player.animation_player.play("run")
		else:
			player.animation_player.play("run-weapon")
	
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
		
	if player.is_on_floor():
		player.player_jumps = 0
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	var target_speed = player.player_max_speed * direction
	player.velocity.x = move_toward(player.velocity.x, target_speed, player.player_acceleration * delta)
	player.debug_speed.text = "Speed %s " % str(player.velocity.x)
	
	if direction == 0:
		player.velocity.x = 0.0
		player.state_machine.change_state("IdleState")
		return
	
	if Input.is_action_just_pressed("jump"):
		if player.player_jumps < player.player_max_jumps:
			player.player_jumps += 1
			player.state_machine.change_state("JumpState")
			return
			
	if direction < 0.0:
		player.sprite.flip_h = true 
	else:
		player.sprite.flip_h = false
