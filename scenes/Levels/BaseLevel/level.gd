extends Node2D
class_name Level


@onready var doors: Array[Node] = $Doors.get_children()

@export var spawn_door: Door

var game: Game
var player: Player


func _ready() -> void:
	player.door_entered.connect(on_player_entered_door)


func spawn_player():
	player.state_machine.change_state("doorout")
	player.velocity = Vector2.ZERO
	player.global_position = spawn_door.global_position
	spawn_door.open_door()


func on_player_entered_door(door: Door):
	if door.target_level_path:
		game.level_transition(door.target_level_path)
