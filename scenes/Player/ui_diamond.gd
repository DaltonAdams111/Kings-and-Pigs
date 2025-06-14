extends Node2D
class_name UIDiamond


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var counter: RichTextLabel = $Counter


var diamond_count: int = 0:
	set(value):
		var new_count: int = clamp(value, 0, 999)
		diamond_count = new_count
		update_counter(diamond_count)


func update_counter(count: int) -> void:
	counter.text = str(count)
