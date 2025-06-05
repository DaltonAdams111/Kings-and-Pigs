@tool
extends Resource
class_name ItemSlot


## Class for collecting and organizing [Item]s.


## Emitted when the [member item] or [item_count] changes.
signal item_changed(new_item: Item, new_count: int)

## The [Item] this [ItemSlot] contains.
@export var item: Item = null:
	set(value):
		var new_item: Item = value
		if item != new_item:
			item = new_item
			item_changed.emit(item, item_count)
		
		if item:
			item.property_list_changed.connect(notify_property_list_changed)
		notify_property_list_changed()

## The quantity of this [member item] this [ItemSlot] contains.
var item_count: int = 1:
	set(value):
		var new_count: int = max(0, value)
		if item_count != new_count:
			item_count = new_count
			item_changed.emit(item, item_count)


func _init(new_item: Item = null, new_item_count: int = 1) -> void:
	item = new_item
	item_count = new_item_count


## Increases the [member item_count] of this [Item].[br][br]
## Will not reduce the [member item_count] if a negative value is provided, see [method remove_items] instead.
func add_items(quantity: int) -> void:
	item_count += quantity


## Reduces the [member item_count] of this [Item].[br][br]
## Will not increase the [member item_count] if a negative value is provided, see [method add_items] instead.
func remove_items(quantity: int) -> void:
	item_count -= quantity


#region Custom Property List
func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	if item and item.is_stackable:
		properties.append({
			"name": "item_count",
			"type": TYPE_INT,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "0, 100, 1, or_greater"
		})
	else:
		item_count = 1
	
	return properties


func _property_can_revert(property: StringName) -> bool:
	if property == "item_count":
		return true
	return false


func _property_get_revert(property: StringName) -> Variant:
	if property == "item_count":
		return 1
	return
#endregion
