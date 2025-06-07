extends Node


@onready var level_group: Node2D = $LevelGroup
@onready var player_group: Node2D = $PlayerGroup

const PLAYER_SCENE_PATH: String = "res://scenes/Player/player.tscn"

var current_level: Level = null
var player: Player = null


func _ready() -> void:
	load_player()
	level_transition("res://scenes/Levels/LevelTest/level_test.tscn")


func level_transition(new_level_path: String):
	if current_level:
		current_level.queue_free()
	
	var new_level: Level = load(new_level_path).instantiate()
	current_level = new_level
	
	level_group.add_child(current_level)
	current_level.spawn_player()


func load_player():
	if player:
		player.queue_free()
	
	player = load(PLAYER_SCENE_PATH).instantiate()
	player_group.add_child(player)


func get_player():
	return player
