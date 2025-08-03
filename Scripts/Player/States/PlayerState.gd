# res://Scripts/Player/States/PlayerState.gd

extends Node

class_name PlayerState

var player: Player

func enter(_player: Player) -> void:
	player = _player

func exit() -> void:
	pass
	
func process_update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func input_update(_event: InputEvent) -> void:
	pass
