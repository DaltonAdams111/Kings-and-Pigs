extends Node


var player: Player = null
var current_level: Level = null


var paused: bool = false


func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		paused = not paused
		if paused:
			get_tree().paused = true
		else:
			get_tree().paused = false
