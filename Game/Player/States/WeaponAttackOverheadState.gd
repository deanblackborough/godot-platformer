# res://Game/Player/States/WeaponAttackOverheadState.gd

extends PlayerState

class_name WeaponAttackOverheadState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.velocity.x = 0
	
	player.play_animation("weapon-attack-overhead")
		
func on_animation_finished(_animation: StringName):
	if _animation == "weapon-attack-overhead":
		
		player.is_attacking = false;
		
		if not player.is_on_floor():
			player.state_machine.change_state("FallState")
		elif player.direction != 0.0 and not player.is_crouched:
			player.state_machine.change_state("RunState")
		elif player.is_crouched:
			player.state_machine.change_state("IdleCrouchState")
		else:
			player.state_machine.change_state("IdleState")
	
func process_update(_delta):
	pass
		

func physics_update(_delta):
	pass
		
