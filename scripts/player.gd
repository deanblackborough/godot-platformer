extends CharacterBody2D

@export var player_speed: float = 200.0;
@export var player_jump_force: float = -425;
@export var gravity: float = 20;
@export var terminal_velocity: float = 525; 

func _physics_process(delta):
	
	if is_on_floor() == false:
		velocity.y += gravity;
		
		if velocity.y > terminal_velocity:
			velocity.y = terminal_velocity;
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = player_jump_force;
	
	var player_direction = Input.get_axis("moveLeft", "moveRight");
	
	velocity.x = player_speed * player_direction;
	
	draw_player_sprite(
		player_direction, 
		player_speed,
		velocity.y,
		is_on_floor()
	);
	
	move_and_slide();
	
	print(player_direction);
	print(player_speed);
	print(velocity);
	
func draw_player_sprite(
	player_direction: float, 
	player_speed: float,
	player_velocity_y: float, 
	player_on_floor: bool
):
	if not player_on_floor:
		if player_velocity_y < 0:
			$AnimatedSprite2D.animation = "jump"
			## Add fall animation
	else:
		if player_direction != 0:
			$AnimatedSprite2D.scale.x = player_direction
			$AnimatedSprite2D.animation = "run"
		else:
			$AnimatedSprite2D.animation = "idle"
