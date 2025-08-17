# res://Core/Combat/Hitbox.gd

extends Area2D

class_name Hitbox

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var active: bool = false
var initial_transform: Transform2D

func _ready():
	initial_transform = transform
	disable()
	
func disable():
	active = false
	monitoring = false
	collision_shape.disabled = true

func set_active(_on: bool):
	if active == _on:
		return
		
	active = _on
	set_deferred("monitoring", active)
	collision_shape.disabled = not active
	
	if not _on:
		call_deferred("reset_pose")

func is_active() -> bool:
	
	return active
	
func reset_pose():
	transform = initial_transform
