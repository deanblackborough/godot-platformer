# res://Scripts/Player/States/RunState.gd

extends PlayerState

class_name RunState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.play_animation("run", true)
		
func process_update(_delta):
	
	if Input.is_action_just_pressed("toggleWeapon"):
		player.weapon_drawn = !player.weapon_drawn
		player.play_animation("run", true)
			
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	if direction == 0:
		player.state_machine.change_state("IdleState")
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
	
	if Input.is_action_just_pressed("jump") and player.can_jump(): 
		player.try_to_jump()
		return
