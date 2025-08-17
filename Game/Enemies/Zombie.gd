# res://Game/Enemies/Zombie.gd

extends CharacterBody2D

class_name Zombie

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	
	animation_player.play("idle")
