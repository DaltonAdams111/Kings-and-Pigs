extends Node
class_name InventoryComponent


## Component for managing the inventory of an object.


## Emitted when [ItemSlot]s are added or removed from the [member inventory]
## or when any of its [ItemSlot]s properties change.
signal inventory_changed

## Array containing [ItemSlot]s which hold [Item] data.
@export var inventory: Array[ItemSlot]


## Checks if any [ItemSlot] contains the provided [Item].
func has_item(item: Item) -> bool:
	return inventory.any(func(item_slot: ItemSlot): return item_slot.item.name == item.name)


## Checks if any [ItemSlot] contains the provided [Item] name.
func has_item_name(item_name: String) -> bool:
	return inventory.any(func(item_slot: ItemSlot): return item_slot.item.name == item_name)


## Searches the [member inventory] for the provided [Item], returning the [ItemSlot] containing
## the [Item]. Returns [code]null[/code] if the [param item] was not found.
func find_item(item: Item) -> ItemSlot:
	var index: int = find_item_index(item, inventory)
	if index == -1:
		return null
	
	return inventory[index]


## Finds the index of the [ItemSlot] in the [param some_inventory] containing the [param item],
## returning [code]-1[/code] if the [param item] was not found.
static func find_item_index(item: Item, some_inventory: Array[ItemSlot]) -> int:
	return some_inventory.find_custom(func(item_slot: ItemSlot): return item_slot.item.name == item.name)


## Searches the [member inventory] for the provided [Item] name, returning the [ItemSlot] containing
## the [Item]. Returns [code]null[/code] if the [param item_name] was not found.
func find_item_name(item_name: String) -> ItemSlot:
	var index: int = find_item_name_index(item_name, inventory)
	if index == -1:
		return null
	
	return inventory[index]


## Finds the index of the [ItemSlot] in the [param some_inventory] containing the [param item_name],
## returning [code]-1[/code] if the [param item_name] was not found.
static func find_item_name_index(item_name: String, some_inventory: Array[ItemSlot]) -> int:
	return some_inventory.find_custom(func(item_slot: ItemSlot): return item_slot.item.name == item_name)


## Merges any [ItemSlot]s that contain the same item and can be stacked.
func consolidate_items() -> void:
	var new_inventory: Array[ItemSlot]
	
	for slot in inventory:
		var item: Item = slot.item
		if item.name not in new_inventory.map(func(item_slot: ItemSlot): return item_slot.item.name):
			var new_slot = ItemSlot.new(item, slot.item_count)
			new_inventory.append(new_slot)
		elif not item.is_stackable:
			var new_slot = ItemSlot.new(item, slot.item_count)
			new_inventory.append(new_slot)
		else:
			new_inventory[find_item_index(item, new_inventory)].add_items(slot.item_count)
	
	inventory = new_inventory
	inventory_changed.emit()


## Increases the [member ItemSlot.item_count] of the provided [param item].
## If an [ItemSlot] containing the [param item] does not exist, a new [ItemSlot] will
## be created to hold the new [Item] and will be appended to the [member inventory].[br][br]
## Will not remove items if a negative value is provided, see [method remove_item].
func add_item(item: Item, quantity: int) -> void:
	if has_item(item):
		var item_slot: ItemSlot = find_item(item)
		item_slot.add_items(quantity)
	else:
		var item_slot: ItemSlot = ItemSlot.new(item, quantity)
		inventory.append(item_slot)
	
	inventory_changed.emit()


## Decreases the [member ItemSlot.item_count] of the provided [param item]
## if it exists in the [member inventory].
## If the new [member ItemSlot.item_count] is [code]0[/code],
## the [ItemSlot] will be erased from the [member inventory].[br][br]
## Will not add items if a negative value is provided, see [method add_item].
func remove_item(item: Item, quantity: int) -> void:
	remove_item(item, quantity)
	if not has_item(item):
		return
	
	var item_slot: ItemSlot = find_item(item)
	item_slot.remove_items(quantity)
	
	if item_slot.item_count == 0:
		inventory.erase(item_slot)
	
	inventory_changed.emit()
