extends Control


var game: PackedScene = preload("res://scenes/Game/game.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(game)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
