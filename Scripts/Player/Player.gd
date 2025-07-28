# res://Scripts/Player/Player.gd

extends CharacterBody2D

class_name Player

@export var world_gravity: float = 1920
@export var world_terminal_velocity: float = 525

@export var player_speed: float = 140.0
@export var player_jump_force: float = -450
@export var player_max_jumps: int = 1

var player_jumps: int = 0
var player_hard_land_time: float = 0.3
var player_weapon_drawn: bool = false

@onready var state_machine: StateMachine = $StateMachine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var debug_state: Label = $CanvasLayer/MarginContainer/VBoxContainer/State
@onready var debug_speed: Label = $CanvasLayer/MarginContainer/VBoxContainer/Speed
@onready var debug_weapon_drawn: Label = $CanvasLayer/MarginContainer/VBoxContainer/WeaponDrawn
@onready var debug_jumps: Label = $CanvasLayer/MarginContainer/VBoxContainer/Jumps

func _ready():
	$Camera2D.zoom = Vector2(2, 2)
	state_machine.change_state("IdleState")
	
func _process(delta):
	debug_weapon_drawn.text = "WeaponDrawn: %s" % str(player_weapon_drawn)
	debug_jumps.text = "Jumps: %d" % player_jumps

func _physics_process(delta):
	state_machine.physics_update(delta)
	move_and_slide()
