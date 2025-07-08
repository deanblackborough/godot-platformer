extends CharacterBody2D

@export var world_gravity: float = 20;
@export var world_terminal_velocity: float = 525;

@export var player_speed: float = 200.0;
@export var player_jump_force: float = -425;
@export var player_max_jumps: int = 2; 

var player_jumps: int = 0;

func _physics_process(delta):
	
	if is_on_floor() == false:
		velocity.y += world_gravity;
		
		if velocity.y > world_terminal_velocity:
			velocity.y = world_terminal_velocity;
			
	if (is_on_floor()):
		player_jumps = 0;
	
	if Input.is_action_just_pressed("jump") and player_jumps < player_max_jumps:
		player_jumps += 1
		velocity.y = player_jump_force
	
	var player_direction = Input.get_axis("moveLeft", "moveRight")
	
	velocity.x = player_speed * player_direction
	
	draw_player_sprite(
		player_direction, 
		player_speed,
		velocity.y,
		is_on_floor()
	);
	
	move_and_slide();
	
	print(player_jumps);
	#print(player_direction);
	#print(player_speed);
	#print(velocity);
	
func draw_player_sprite(
	player_direction: float, 
	player_speed: float,
	player_velocity_y: float, 
	player_on_floor: bool
):
	if not player_on_floor:
		if player_velocity_y < 0:
			$AnimatedSprite2D.animation = "jump";
			## Add fall animation
	else:
		if player_direction != 0:
			$AnimatedSprite2D.animation = "run";
		else:
			$AnimatedSprite2D.animation = "idle";

	if player_direction != 0:
		$AnimatedSprite2D.scale.x = player_direction;
