# res://Scripts/Player/States/WeaponAttackJabState.gd

extends PlayerState

class_name WeaponAttackJabState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.velocity.x = 0
	
	player.play_animation("weapon-attack-jab")
		
func on_animation_finished(_animation: StringName):
	if _animation == "weapon-attack-jab":
		player.state_machine.change_state("IdleState")
	
func process_update(_delta):
	pass
		

func physics_update(_delta):
	pass
		
