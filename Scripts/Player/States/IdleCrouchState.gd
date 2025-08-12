# res://Scripts/Player/States/IdleCrouchState.gd

extends PlayerState

class_name IdleCrouchState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.is_crouched_changed.connect(_on_is_crouch_changed)
	
	player.velocity.x = 0
	
	player.set_collision_shape(player.collision_shapes.CROUCHED)
	player.play_animation("idle-crouch")
	
func _on_is_crouch_changed(new_value: bool):
	if new_value == false:
		player.state_machine.change_state("IdleState")
		return
		
func exit():
	player.is_crouched_changed.disconnect(_on_is_crouch_changed)

func process_update(_delta):
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	if direction == 0 and player.is_crouched == false:
		player.state_machine.change_state("IdleCrouchState")
		return
	
	if direction != 0 and player.is_crouched == false:
		player.state_machine.change_state("RunState")
		return
		
	if direction != 0 and player.is_crouched == true:
		player.state_machine.change_state("WalkCrouchState")
		return

func physics_update(_delta):
			
	if not player.is_on_floor():
		player.force_stand()
		player.state_machine.change_state("FallState")
		return
		
	if Input.is_action_just_pressed("jump"): 
		player.queue_jump()
		return
		
