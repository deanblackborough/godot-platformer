# res://Core/StateMachine/PlayerState.gd

extends Node

class_name PlayerState

var player: Player

# Set/Reset State/vars and Set Animations
func enter(_player: Player) -> void:
	player = _player

# Any cleanup
func exit() -> void:
	pass

# Visual changes and UI updates and Input
func process_update(_delta: float) -> void:
	pass

# Movement, Velocity, Ground/air checks
func physics_update(_delta: float) -> void:
	pass
	
func on_animation_finished(_animation: StringName) -> void:
	pass

func on_is_crouched_changed(_new_value: bool) -> void:
	pass

func on_weapon_drawn_changed(_new_value: bool) -> void:
	pass
