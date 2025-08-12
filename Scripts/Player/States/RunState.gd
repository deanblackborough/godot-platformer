# res://Scripts/Player/States/RunState.gd

extends PlayerState

class_name RunState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.is_crouched_changed.connect(_on_is_crouch_changed)
	
	player.set_collision_shape(player.collision_shapes.STANDING)
	player.play_animation("run", player.weapon_drawn)
	
func _on_is_crouch_changed(new_value: bool):
	if new_value == true:
		player.state_machine.change_state("WalkCrouchState")
		return
		
func exit():
	player.is_crouched_changed.disconnect(_on_is_crouch_changed)
		
func process_update(_delta):
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	if direction == 0 and player.is_crouched == false:
		player.state_machine.change_state("IdleState")
		return
		
	if direction == 0 and player.is_crouched == true:
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
