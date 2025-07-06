extends Node
class_name Game


signal game_ready

@onready var level_group: Node2D = $LevelGroup
@onready var player_group: Node2D = $PlayerGroup

const PLAYER_SCENE_PATH: String = "res://scenes/Player/player.tscn"


func _ready() -> void:
	load_player()
	level_transition("res://scenes/Levels/LevelTest/level_test.tscn")


func level_transition(new_level_path: String):
	if Globals.current_level:
		Globals.current_level.queue_free()
	
	var new_level: Level = load(new_level_path).instantiate()
	new_level.game = self
	Globals.current_level = new_level
	
	level_group.add_child(Globals.current_level)
	Globals.current_level.spawn_player()


func load_player():
	if Globals.player:
		Globals.player.queue_free()
	
	Globals.player = load(PLAYER_SCENE_PATH).instantiate()
	player_group.add_child(Globals.player)


func _on_ready() -> void:
	game_ready.emit()
