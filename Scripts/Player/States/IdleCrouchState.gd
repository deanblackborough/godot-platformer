# res://Scripts/Player/States/IdleCrouchState.gd

extends PlayerState

class_name IdleCrouchState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.velocity.x = 0
	player.is_crouched = true
	
	player.set_collision_shape(player.collision_shapes.CROUCHED)
	player.play_animation("idle-crouch")

func process_update(_delta):
	
	if Input.is_action_just_pressed("crouch"):
		player.state_machine.change_state("IdleState")
		return
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	if player.is_on_floor() && direction != 0:
		player.state_machine.change_state("RunState")
		return


func physics_update(_delta):
			
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
		
