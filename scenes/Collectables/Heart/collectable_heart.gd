extends Collectable
class_name CollectableHeart


func _on_collected(body: Node2D, inventory: InventoryComponent) -> void:
	if body is Player:
		inventory.add_item(item)
		body.health_component.heal(1)
		queue_free()
