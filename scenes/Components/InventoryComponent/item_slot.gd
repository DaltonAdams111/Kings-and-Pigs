extends Resource
class_name ItemSlot


## Class for collecting and organizing [Item]s.


## The [Item] this [ItemSlot] contains.
@export var item: Item
## The amount of this [member item] this [ItemSlot] contains.
@export var item_count: int


func _init(new_item: Item = null, new_item_count: int = 0) -> void:
	item = new_item
	item_count = new_item_count
		
