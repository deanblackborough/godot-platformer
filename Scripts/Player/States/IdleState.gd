# res://Scripts/Player/States/IdleState.gd

extends PlayerState

class_name IdleState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.velocity.x = 0
	
	player.set_collision_shape(player.collision_shapes.STANDING)
	player.play_animation("idle", player.weapon_drawn)
	
func on_is_crouched_changed(_new_value: bool):
	if _new_value == true:
		player.state_machine.change_state("IdleCrouchState")
		return
		
func on_weapon_drawn_changed(_new_value: bool):
	player.play_animation("idle", player.weapon_drawn)
	return

func process_update(_delta):
	
	var direction = player.direction
	
	if direction == 0 and player.is_crouched == true:
		player.state_machine.change_state("IdleCrouchState")
		return
		
	if direction != 0 and player.is_crouched == true:
		player.state_machine.change_state("WalkCrouchState")
		return
		
	if direction != 0 and player.is_crouched == false:
		player.state_machine.change_state("RunState")
		return

func physics_update(_delta):
	
	if Input.is_action_just_pressed("jump"):
		player.queue_jump()
		return
			
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
		
