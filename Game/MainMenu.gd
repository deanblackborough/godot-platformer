extends Control

func _on_play_pressed() -> void:
	var transition_manager := TransitionManager.new()
	get_tree().root.add_child(transition_manager)
	await transition_manager.change_scene_with_fade("res://Game/Game.tscn")
