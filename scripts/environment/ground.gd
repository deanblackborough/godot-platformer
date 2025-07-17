@tool extends StaticBody2D

@export var length: float = 50.0: 
	set(value): 
		length = value 
		update_properties()
		
func _ready(): 
	update_properties()
	
func update_properties(): 
	$Sprite2D.region_rect.size.x = length 
	$CollisionShape2D.shape.size.x = length
