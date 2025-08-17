# res://Core/Combat/Hitbox.gd

extends Area2D

class_name Hitbox

signal activated
signal deactivated

@onready var collision_shapes: Array[CollisionShape2D] = []

var active: bool = false
var initial_transform: Transform2D
var already_hit := {}

func _ready():
	for shape in get_children():
		if shape is CollisionShape2D:
			collision_shapes.append(shape)
			
	initial_transform = transform
	disable()
	connect("area_entered", Callable(self, "on_area_entered"))
	
func disable():
	active = false
	monitoring = false
	for shape in collision_shapes:
		shape.disabled = true
	already_hit.clear()

func set_active(_on: bool):
	if active == _on:
		return
		
	active = _on
	set_deferred("monitoring", active)
	
	for shape in collision_shapes:
		shape.disabled = not _on
		
	if _on:
		emit_signal("activated")
	else:
		already_hit.clear()
		emit_signal("deactivated")
		call_deferred("reset_pose")

func is_active() -> bool:
	return active
	
func reset_pose():
	transform = initial_transform
	
func on_area_entered(area: Area2D) -> void:
	if not active:
		return
		
	if not area or not area.has_method("hit"):
		return
		
	var id := area.get_instance_id()
	if already_hit.has(id):
		return
		
	already_hit[id] = true
	
	area.hit(null, self)
