@tool extends StaticBody2D

@export_range(32.0, 640.0)
var length: float = 32.0: 
	set(value): 
		length = max(value, 32.0) 
		update_properties()
		
@export_range(32.0, 640.0)
var height: float = 32.0: 
	set(value): 
		height = max(value, 32.0) 
		update_properties()
		
func _ready(): 
	update_properties()
	
func _process(delta: float):
	if Engine.is_editor_hint():
		update_properties()
	
func update_properties(): 
	$Sprite2D.region_rect.size = Vector2(length, height)
	$Sprite2D.region_rect.position = Vector2(0, 0)
	$Sprite2D.position = Vector2(length / 2, height / 2)
	
	$CollisionShape2D.shape.size = Vector2(length, height)
	$CollisionShape2D.position = Vector2(length / 2, height / 2)
