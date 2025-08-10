# res://Scripts/Player/States/IdleState.gd

extends PlayerState

class_name IdleState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.velocity.x = 0
	
	player.play_animation("idle", true)

func process_update(_delta):
	
	if Input.is_action_just_pressed("toggleWeapon"):
		player.weapon_drawn = !player.weapon_drawn
		player.play_animation("idle", true)
		
	var direction = Input.get_axis("moveLeft", "moveRight")
	if player.is_on_floor() && direction != 0:
		player.state_machine.change_state("RunState")
		return


func physics_update(_delta):
	
	if Input.is_action_just_pressed("jump"):
		player.queue_jump()
		return
			
	if not player.is_on_floor():
		player.state_machine.change_state("FallState")
		return
		
