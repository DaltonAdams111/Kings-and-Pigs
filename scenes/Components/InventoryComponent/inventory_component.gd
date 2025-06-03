extends Node
class_name InventoryComponent


## Component for managing the inventory of an object.


## Emitted when the [member inventory] changes.
@warning_ignore("unused_signal")
signal inventory_changed

@export var inventory: Array[ItemSlot]
