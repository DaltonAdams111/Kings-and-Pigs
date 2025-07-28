extends Control


func _on_resume_button_pressed() -> void:
	Game.resume_game()


func _on_main_menu_button_pressed() -> void:
	Game.open_main_menu()
