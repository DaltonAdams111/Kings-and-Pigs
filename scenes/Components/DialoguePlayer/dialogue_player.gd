@tool
extends Node2D
class_name DialoguePlayer

@export_tool_button("Test", "Callable") var action = test
## Used for testing to alight the dialogue box correctly.
func test() -> void:
	animation_player.play("Test")


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func show_dialogue(dialogue_name: String) -> void:
	var dialogue_names: PackedStringArray = animation_player.get_animation_list()
	if not dialogue_names.has(dialogue_name):
		return
	
	animation_player.play(dialogue_name)
