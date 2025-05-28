extends Node
class_name State


@warning_ignore("unused_signal")
signal change_state(new_state_name: String)


@export var can_flip_sprite: bool = false


func enter() -> void:
	pass


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
