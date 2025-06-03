extends Resource
class_name Item


## Class that contains data and methods for items.


## The name of this [Item].
@export var item_name: String
## The corresponding scene for this [Item].
@export var item_scene: PackedScene = null


func _init(name: String = "", scene: PackedScene = null) -> void:
	item_name = name
	item_scene = scene
