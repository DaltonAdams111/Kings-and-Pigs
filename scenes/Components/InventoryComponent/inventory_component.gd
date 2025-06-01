extends Node
class_name InventoryComponent


## Component for managing the inventory of an object.


## Emitted when the [member inventory] changes.
signal inventory_changed(new_inventory: Dictionary[Item, int])

enum Item{
	None,
	Diamond,
	Heart,
}

## The items this [InventoryComponent] starts with.
@export var inventory: Dictionary[Item, int]

const COLLECTABLE_HEART = preload("res://scenes/Collectables/Heart/collectable_heart.tscn")


func add_item(item: Item, count: int):
	if item == Item.None:
		return
	
	if inventory.has(item):
		inventory[item] += count
	else:
		inventory.set(item, count)
	
	inventory_changed.emit(inventory)
	print(inventory)


func remove_item(item: Item, count: int):
	if item == Item.None:
		return
	
	if not inventory.has(item):
		return
	
	inventory[item] -= count
	
	if inventory[item] <= 0:
		inventory.erase(item)
	
	inventory_changed.emit(inventory)
	print(inventory)


func drop_item(item: Item):
	if item == Item.None:
		return
	
	if inventory.has(item):
		pass
