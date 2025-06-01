extends RigidBody2D


@onready var collectable_component: CollectableComponent = $CollectableComponent


func _on_collectable_component_collected(inventory: InventoryComponent) -> void:
	inventory.add_item(collectable_component.item_type, 1)
	call_deferred("queue_free")
