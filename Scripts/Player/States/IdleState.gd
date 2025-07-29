# res://Scripts/Player/States/IdleState.gd

extends PlayerState

class_name IdleState

func enter(_player):
	super.enter(_player)
	
	if player.player_weapon_drawn == false:
		player.animation_player.play("idle")
	else:
		player.animation_player.play("idle-weapon")

func physics_update(delta):
	if Input.is_action_just_pressed("toggleWeapon"):
		player.player_weapon_drawn = !player.player_weapon_drawn
		if player.player_weapon_drawn == false:
			player.animation_player.play("idle")
		else:
			player.animation_player.play("idle-weapon")
	
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
		
	if player.is_on_floor():
		player.player_jumps = 0
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	if direction != 0:
		player.state_machine.change_state("RunState")
		return
	
	if Input.is_action_just_pressed("jump"):
		if player.player_jumps < player.player_max_jumps:
			player.player_jumps += 1
			player.state_machine.change_state("JumpState")
			return
