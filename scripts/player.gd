extends CharacterBody2D

@export var playerSpeed = 150;
@export var playerJumpForce = -325;
@export var gravity = 30;
@export var terminalVelocity = 500; 

func _physics_process(delta):
	
	if is_on_floor() == false:
		velocity.y += gravity;
		
		if velocity.y > terminalVelocity:
			velocity.y = terminalVelocity;
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = playerJumpForce;
	
	var playerDirection = Input.get_axis("moveLeft", "moveRight");
	velocity.x = playerSpeed * playerDirection;
	move_and_slide();
	
	print(velocity);
