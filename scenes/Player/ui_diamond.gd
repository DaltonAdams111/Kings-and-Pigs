extends Node2D
class_name UIDiamond


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var counter: RichTextLabel = $Counter


func update_counter(count: int) -> void:
	counter.text = str(count)
