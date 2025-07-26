# res://Scripts/Player/Player.gd
extends CharacterBody2D

@export var world_gravity: float = 32;
@export var world_terminal_velocity: float = 525;

@export var player_speed: float = 140.0;
@export var player_jump_force: float = -450;
@export var player_max_jumps: int = 1;

var player_jumps: int = 0;

func _ready():
	$Camera2D.zoom = Vector2(2, 2)

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
	
func draw_player_sprite(
	player_direction: float, 
	player_speed: float,
	player_velocity_y: float, 
	player_on_floor: bool
):
	if not player_on_floor:
		if player_velocity_y < 0:
			$AnimatedSprite2D.animation = "Jump";
			## Add fall animation
	else:
		if player_direction != 0:
			$AnimatedSprite2D.animation = "Run";
		else:
			$AnimatedSprite2D.animation = "Idle";

	if player_direction != 0:
		$AnimatedSprite2D.scale.x = player_direction;
