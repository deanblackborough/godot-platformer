# res://Scripts/Player/Player.gd

extends CharacterBody2D

class_name Player

@export_group("World")
@export var world_gravity: float = 1500
@export var world_terminal_velocity: float = 500

@export_group("Player Movement")
@export var max_speed: float = 140.0
@export var ground_acceleration: int = 1500
@export var ground_deacceleration: int = 1500

@export_group("Player Jumping")
@export var jump_force: float = -500
@export var max_jumps: int = 2

@export_group("Player Feel")
@export var hard_land_run_time: float = 0.8
@export var hard_land_fall_time: float = 0.4
@export var land_run_time: float = 0.2

var jumps: int = 0
var weapon_drawn: bool = false

@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@onready var debug_state: Label = $CanvasLayer/MarginContainer/VBoxContainer/State
@onready var debug_max_speed: Label = $CanvasLayer/MarginContainer/VBoxContainer/MaxSpeed
@onready var debug_speed: Label = $CanvasLayer/MarginContainer/VBoxContainer/Speed
@onready var debug_weapon_drawn: Label = $CanvasLayer/MarginContainer/VBoxContainer/WeaponDrawn
@onready var debug_jumps: Label = $CanvasLayer/MarginContainer/VBoxContainer/Jumps

func _ready():
	$Camera2D.zoom = Vector2(2, 2)
	
	debug_max_speed.text = "MaxSpeed: +/- %s" % str(max_speed)
	state_machine.change_state("IdleState")
	
func _process(delta: float):
	state_machine.process_update(delta)
	debug_weapon_drawn.text = "WeaponDrawn: %s" % str(weapon_drawn)
	debug_jumps.text = "Jumps: %d" % jumps

func _physics_process(delta: float):
	
	if not is_on_floor():
		velocity.y = min(velocity.y + world_gravity * delta, world_terminal_velocity)	
	
	state_machine.physics_update(delta)
	move_and_slide()
	
func play_animation(animation: String, weapon_version: bool = false):
	if weapon_version == true and weapon_drawn == true:
		animation_player.play("%s-weapon" % animation)
	else:
		animation_player.play(animation)
		
func can_jump() -> bool:
	if jumps < max_jumps:
		return true
			
	return false
	
func try_to_jump():
		state_machine.change_state("JumpState")
		jumps += 1
		return
	
