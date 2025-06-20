extends CanvasLayer
class_name PlayerUI

@onready var player: Player = $".."
@onready var hearts: Node2D = $Hearts
@onready var ui_diamond: UIDiamond = $UIDiamond

var player_hearts: Array[UIHeart]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children = hearts.get_children()
	for child in children:
		if child is UIHeart:
			player_hearts.append(child)


func update_hearts(new_health: int) -> void:
	pass
	for heart in player_hearts:
		if heart.get_index() + 1 <= new_health:
			heart.add()
		else:
			heart.remove()


func update_diamonds(count: int) -> void:
	var diamond_count: int = clampi(count, 0, 999)
	ui_diamond.update_counter(diamond_count)
