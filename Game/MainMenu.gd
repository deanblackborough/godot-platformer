extends Control

func _on_play_pressed() -> void:
	var level = "res://Game/Game.tscn"
	get_tree().change_scene_to_file(level)
