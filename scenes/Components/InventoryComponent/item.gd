@tool
extends Resource
class_name Item


## Class that contains data and methods for items.


## The name of this [Item].
@export var name: String = ""

##
@export var is_stackable: bool = false:
	set(value):
		is_stackable = value
		notify_property_list_changed()

## The corresponding scene for this [Item].
@export var scene_path: String = ""


func _init(item_name: String = "", item_is_stackable: bool = false, item_scene_path: String = "") -> void:
	name = item_name
	is_stackable = item_is_stackable
	scene_path = item_scene_path
