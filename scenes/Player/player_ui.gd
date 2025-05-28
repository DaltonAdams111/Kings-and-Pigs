extends CanvasLayer

@onready var player: Player = $".."
@onready var hearts: Node2D = $Hearts

var player_hearts: Array[Sprite2D]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children = hearts.get_children()
	for child in children:
		if child is Sprite2D:
			player_hearts.push_back(child)


func update_hearts(health: int):
	for heart in player_hearts:
		if heart.get_index() + 1 <= health:
			heart.visible = true
		else:
			heart.visible = false
