# res://Scripts/Player/Player.gd

extends CharacterBody2D

class_name Player

@export_group("World")
@export var world_gravity: float = 1800
@export var world_terminal_velocity: float = 500

@export_group("Player Movement")
@export var max_speed: float = 160.0
@export var max_speed_crouched: float = 100.0
@export var ground_acceleration: int = 1500
@export var ground_deacceleration: int = 2000
@export var air_acceleration: int = 800
@export var air_deacceleration: int = 1000

@export_group("Player Jumping")
@export var jump_force: float = -400
@export var max_jumps: int = 1

@export_group("Player Feel")
@export var hard_land_run_time: float = 0.8
@export var hard_land_fall_time: float = 0.6
@export var land_run_time: float = 0.2
@export var coyote_time : float = 0.1
@export var buffer_time : float = 0.12
@export var coyote_timer : float = 0.0
@export var buffer_timer : float = -1.0

var jumps: int = 0
var weapon_drawn: bool = false
var is_crouched: bool = false

var direction :float = 0.0
var facing_direction: int = 1 # 1 is right, -1 is left

signal is_crouched_changed(new_value: bool)
signal is_weapon_drawn_changed(new_value: bool)

@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@onready var collision_shape_standing: CollisionShape2D = $CollisionShapeStanding
@onready var collision_shape_crouched: CollisionShape2D = $CollisionShapeCrouched
@onready var collision_ray_cast: RayCast2D = $CanStandRayCast 

@onready var debug_state: Label = $CanvasLayer/MarginContainer/VBoxContainer/State
@onready var debug_max_speed: Label = $CanvasLayer/MarginContainer/VBoxContainer/MaxSpeed
@onready var debug_speed: Label = $CanvasLayer/MarginContainer/VBoxContainer/Speed
@onready var debug_weapon_drawn: Label = $CanvasLayer/MarginContainer/VBoxContainer/WeaponDrawn
@onready var debug_jumps: Label = $CanvasLayer/MarginContainer/VBoxContainer/Jumps
@onready var debug_is_crouched: Label = $CanvasLayer/MarginContainer/VBoxContainer/IsCrouched

enum collision_shapes { STANDING, CROUCHED }

var active_collision_shape := collision_shapes.STANDING

func _ready():
	$Camera2D.zoom = Vector2(2, 2)
	
	animation_player.animation_finished.connect(_on_animation_finished)
	is_crouched_changed.connect(_on_is_crouched_changed)
	is_weapon_drawn_changed.connect(_on_weapon_drawn_changed)
	
	set_collision_shape(active_collision_shape)
	debug_max_speed.text = "MaxSpeed: +/- %s" % str(max_speed)
	state_machine.change_state("IdleState")
	
func _on_animation_finished(animation: StringName) -> void:
	if state_machine.current_state:
		state_machine.current_state.on_animation_finished(animation)

func _on_is_crouched_changed(new_value: bool) -> void:
	if state_machine.current_state:
		state_machine.current_state.on_is_crouched_changed(new_value)

func _on_weapon_drawn_changed(new_value: bool) -> void:
	if state_machine.current_state:
		state_machine.current_state.on_weapon_drawn_changed(new_value)

func _input(event: InputEvent):
	
	if weapon_drawn and Input.is_action_just_pressed("attackJab"):
		state_machine.change_state("WeaponAttackJabState")
		return
	
	direction = Input.get_axis("moveLeft", "moveRight")
	
	if direction != 0.0:
		facing_direction = sign(direction)
		sprite.scale.x = facing_direction
	
	if event.is_action_pressed("crouch"):
		var new_value := !is_crouched

		if new_value == false and can_stand() == false:
			print_debug("Cannot stand, collision block")
			return
		
		if new_value != is_crouched:
			is_crouched = new_value
			is_crouched_changed.emit(is_crouched)
			print_debug("Is crouched set to " + str(is_crouched))
		
	if Input.is_action_pressed("toggleWeapon"):
		var new_value := !weapon_drawn
		
		if new_value != weapon_drawn:
			weapon_drawn = new_value
			is_weapon_drawn_changed.emit(weapon_drawn)
			print_debug("Weapon drawn set " + str(weapon_drawn))
	
func _process(delta: float):

	state_machine.process_update(delta)
	debug_weapon_drawn.text = "WeaponDrawn: %s" % str(weapon_drawn)
	debug_jumps.text = "Jumps: %d" % jumps
	debug_is_crouched.text = "IsCrouched: %s" % str(is_crouched)

func _physics_process(delta: float):
	
	tick_jump_timers(delta)
	
	if not is_on_floor():
		velocity.y = clamp(velocity.y + world_gravity * delta, -INF, world_terminal_velocity)
	
	state_machine.physics_update(delta)
	move_and_slide()
	
func force_stand() -> void:
	if is_crouched and can_stand():
		is_crouched = false
		is_crouched_changed.emit(false)
		print_debug("Force standing state")
	
func play_animation(animation: String, weapon_version: bool = false):
	if weapon_version == true and weapon_drawn == true:
		animation_player.play("%s-weapon" % animation)
	else:
		animation_player.play(animation)
		
func queue_jump():
	if jumps < max_jumps:
		buffer_timer = buffer_time

func tick_jump_timers(delta):
	if !is_on_floor(): 
		coyote_timer = max(coyote_timer - delta, -1.0)
	else:
		coyote_timer = coyote_time
		jumps = 0
		
	if buffer_timer >= 0.0:
		buffer_timer -= delta
		if can_jump_now():
			do_jump()

func can_jump_now() -> bool:
	return (coyote_timer > 0.0 or jumps < max_jumps) and buffer_timer >= 0.0

func do_jump():
	force_stand()
	
	jumps += 1
	velocity.y = jump_force
	buffer_timer = -1.0
	
func apply_acceleration_in_x_on_ground(direction: float, delta: float) -> float:
	var target_speed = max_speed * direction
	var player_velocity = move_toward(velocity.x, target_speed, ground_acceleration * delta)
	debug_speed.text = "Speed %s " % str(roundf(player_velocity))
	
	return player_velocity
	
func apply_acceleration_in_x_on_ground_crouched(direction: float, delta: float) -> float:
	var target_speed = max_speed_crouched * direction
	var player_velocity = move_toward(velocity.x, target_speed, ground_acceleration * delta)
	debug_speed.text = "Speed %s " % str(roundf(player_velocity))
	
	return player_velocity
	
func apply_acceleration_in_x_in_air(direction: float, delta: float) -> float:
	var target_speed = max_speed * direction
	var player_velocity = move_toward(velocity.x, target_speed, air_acceleration * delta)
	debug_speed.text = "Speed %s " % str(roundf(player_velocity))
	
	return player_velocity
	
func apply_deacceleration_in_x_on_ground(delta: float) -> float:
	var player_velocity = move_toward(velocity.x, 0.0, ground_deacceleration * delta)
	debug_speed.text = "Speed %s " % str(roundf(player_velocity))
	
	return player_velocity
	
func apply_deacceleration_in_x_in_air(delta: float) -> float:
	var player_velocity = move_toward(velocity.x, 0.0, ground_deacceleration * delta)
	debug_speed.text = "Speed %s " % str(roundf(player_velocity))
	
	return player_velocity
	
func can_stand() -> bool:
	if (collision_ray_cast.is_colliding()):
		return false
		
	return true;
	
func set_collision_shape(shape) -> void:
	
	if shape == active_collision_shape:
		return
	
	match shape:
		collision_shapes.STANDING:
			collision_shape_standing.set_deferred("disabled", false)
			collision_shape_crouched.set_deferred("disabled", true)
		collision_shapes.CROUCHED:
			collision_shape_standing.set_deferred("disabled", true)
			collision_shape_crouched.set_deferred("disabled", false)
			
	active_collision_shape = shape
