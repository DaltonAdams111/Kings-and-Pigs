extends CanvasLayer
class_name PlayerUI

@onready var player: Player = $".."
@onready var hearts: Node2D = $Hearts

var player_hearts: Array[UIHeart]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children = hearts.get_children()
	for child in children:
		if child is UIHeart:
			player_hearts.append(child)


func update_hearts(new_health: int):
	pass
	for heart in player_hearts:
		if heart.get_index() + 1 <= new_health:
			heart.add()
		else:
			heart.remove()
