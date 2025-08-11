# res://Scripts/Player/States/WalkCrouchState.gd

extends PlayerState

class_name WalkCrouchState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.is_crouched = true
	player.set_collision_shape(player.collision_shapes.CROUCHED)
	player.play_animation("walk-crouch")
		
func process_update(_delta):
	
	if Input.is_action_just_pressed("crouch") and player.is_crouched == true:
		player.state_machine.change_state("IdleState")
		return
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	if direction == 0:
		player.state_machine.change_state("IdleCrouchState")
		return
		
	if direction < 0.0:
		player.sprite.flip_h = true 
	else:
		player.sprite.flip_h = false

func physics_update(_delta):
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	player.velocity.x = player.apply_acceleration_in_x_on_ground(direction, _delta)
	
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
	
	if Input.is_action_just_pressed("jump"): 
		player.queue_jump()
		return
