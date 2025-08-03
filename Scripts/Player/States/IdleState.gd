# res://Scripts/Player/States/IdleState.gd

extends PlayerState

class_name IdleState

func enter(_player):
	super.enter(_player)
	
	player.play_animation("idle", true)
		
func process_update(delta):
	if Input.is_action_just_pressed("toggleWeapon"):
		player.player_weapon_drawn = !player.player_weapon_drawn
		player.play_animation("idle", true)
		
	var direction = Input.get_axis("moveLeft", "moveRight")
	if player.is_on_floor() && direction != 0:
		player.state_machine.change_state("RunState")
		return
		
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor() && player.player_jumps < player.player_max_jumps:
			player.player_jumps += 1
			player.state_machine.change_state("JumpState")
			return

func physics_update(delta):
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
		
	if player.is_on_floor():
		player.player_jumps = 0
