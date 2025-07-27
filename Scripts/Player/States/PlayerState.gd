# res://Scripts/Player/States/PlayerState.gd

extends Node

class_name PlayerState

var player: Player

func enter(_player: Player) -> void:
	player = _player

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass
