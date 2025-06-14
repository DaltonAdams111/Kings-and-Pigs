extends Collectable
class_name CollectableHeart


func _on_collected(body: Node2D, _inventory: InventoryComponent) -> void:
	if body is Player:
		body.health_component.heal(1)
		queue_free()
