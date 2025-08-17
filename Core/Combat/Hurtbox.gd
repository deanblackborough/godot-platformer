# res://Core/Combat/Hurtbox.gd

extends Area2D

class_name Hurtbox

func hit(_damage, _damaged_by) -> void:
	var enemy_root := get_parent()
	
	if is_instance_valid(enemy_root):
		enemy_root.queue_free()
