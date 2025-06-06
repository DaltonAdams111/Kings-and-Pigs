extends RigidBody2D


@onready var collectable_component: CollectableComponent = $CollectableComponent


func _on_collectable_component_collected(body: Node2D, _inventory: InventoryComponent) -> void:
	if body is Player:
		body.health_component.heal(1)
		call_deferred("queue_free")
