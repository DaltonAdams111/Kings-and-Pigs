extends Node2D
class_name Level


@export var spawn_door: Door


func spawn_player():
	var player: Player = Game.get_player()
	
	player.state_machine.change_state("doorout")
	player.velocity = Vector2.ZERO
	player.global_position = spawn_door.global_position
	spawn_door.open_door()
