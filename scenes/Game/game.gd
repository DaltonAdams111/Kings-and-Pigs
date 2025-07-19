extends Node

signal game_ready

@onready var level_group: Node2D = $LevelGroup
@onready var player_group: Node2D = $PlayerGroup

@onready var main_menu: Control = $CanvasLayer/MainMenu
@onready var pause_menu: Control = $CanvasLayer/PauseMenu


var paused: bool = false:
	set(value):
		paused = value
		get_tree().paused = paused


const PLAYER_SCENE_PATH: String = "res://scenes/Player/player.tscn"
var player: Player = null

var current_level: Level = null

var current_menu: Control = null


func _ready() -> void:
	paused = true
	main_menu.show()
	current_menu = main_menu


func level_transition(new_level_path: String):
	if current_level:
		current_level.queue_free()
	
	var new_level: Level = load(new_level_path).instantiate()
	current_level = new_level
	
	level_group.add_child(current_level)
	current_level.spawn_player()


func load_player() -> void:
	if player:
		player.queue_free()
	
	player = load(PLAYER_SCENE_PATH).instantiate()
	player_group.add_child(player)
	

func get_player() -> Player:
	return player


func start_game() -> void:
	load_player()
	level_transition("res://scenes/Levels/LevelTest/level_test.tscn")
	main_menu.hide()
	paused = false
	current_menu = null


func pause_game() -> void:
	paused = true
	pause_menu.show()
	current_menu = pause_menu


func resume_game() -> void:
	paused = false
	pause_menu.hide()
	current_menu = null


func quit_game() -> void:
	get_tree().quit()


func _on_ready() -> void:
	game_ready.emit()


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("escape"):
		return
	
	if current_menu == main_menu:
		return
	
	if not paused:
		pause_game()
	else:
		resume_game()
