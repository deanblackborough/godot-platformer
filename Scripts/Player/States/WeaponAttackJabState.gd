# res://Scripts/Player/States/WeaponAttackJabState.gd

extends PlayerState

class_name WeaponAttackJabState

func enter(_player: Player):
	
	super.enter(_player)
	
	player.velocity.x = 0
	
	player.play_animation("weapon-attack-jab")
	
	var anim_player = player.animation_player
	if not anim_player.is_connected("animation_finished", Callable(self, "_on_animation_finished")):
		anim_player.animation_finished.connect(_on_animation_finished)
		
func _on_animation_finished(anim_name: StringName):
	if anim_name == "weapon-attack-jab":
		player.state_machine.change_state("IdleState")
	
func process_update(_delta):
	pass
		

func physics_update(_delta):
	pass
		
