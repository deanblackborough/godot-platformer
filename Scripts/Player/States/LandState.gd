extends PlayerState

func enter(_player):
	super.enter(_player)
	player.animated_sprite.animation = "Land"
	player.animated_sprite.play()
	
	var timer := get_tree().create_timer(0.3)  # Adjust to match Land animation duration
	await timer.timeout
	player.state_machine.change_state("IdleState")

func physics_update(delta):
	player.velocity = Vector2.ZERO
	player.move_and_slide()
