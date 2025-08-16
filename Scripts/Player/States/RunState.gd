# res://Scripts/Player/States/RunState.gd

extends PlayerState

class_name RunState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.set_collision_shape(player.collision_shapes.STANDING)
	player.play_animation("run", player.weapon_drawn)
	
func on_is_crouched_changed(_new_value: bool):
	if _new_value == true:
		player.state_machine.change_state("WalkCrouchState")
		return
		
func on_is_weapon_drawn_changed(_new_value: bool):
	player.play_animation("run", player.weapon_drawn)
	return
		
func process_update(_delta):
	
	var direction = player.direction
	
	if direction == 0 and player.is_crouched == false:
		player.state_machine.change_state("IdleState")
		return
		
	if direction == 0 and player.is_crouched == true:
		player.state_machine.change_state("IdleCrouchState")
		return 

func physics_update(_delta):
	
	var direction = player.direction
	player.velocity.x = player.apply_acceleration_in_x_on_ground(direction, _delta)
	
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
	
	if Input.is_action_just_pressed("jump"): 
		player.queue_jump()
		return
