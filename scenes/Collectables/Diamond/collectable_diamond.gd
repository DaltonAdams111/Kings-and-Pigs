extends Collectable
class_name CollectableDiamond


func _on_collected(_body: Node2D, inventory: InventoryComponent) -> void:
	inventory.add_item(item, 1)
	queue_free()
