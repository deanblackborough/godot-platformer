extends CharacterBody2D

@export var player_speed: float = 175.0;
@export var player_jump_force: float = -350;
@export var gravity: float = 25;
@export var terminal_velocity: float = 500; 

func _physics_process(delta):
	
	if is_on_floor() == false:
		velocity.y += gravity;
		
		if velocity.y > terminal_velocity:
			velocity.y = terminal_velocity;
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = player_jump_force;
	
	var player_direction = Input.get_axis("moveLeft", "moveRight");
	
	draw_sprite(player_direction, player_speed);
	
	velocity.x = player_speed * player_direction;
	move_and_slide();
	
	print(player_direction);
	print(player_speed);
	print(velocity);
	
func draw_sprite(player_direction: float, player_speed: float):
	if player_direction != 0:
		$AnimatedSprite2D.scale.x = player_direction;
		
	
