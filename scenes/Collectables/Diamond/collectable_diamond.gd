extends RigidBody2D


@onready var collectable_component: CollectableComponent = $CollectableComponent

var item: Item = load("res://resources/Items/diamond.tres")


func _on_collectable_component_collected(_body: Node2D, inventory: InventoryComponent) -> void:
	inventory.add_item(item, 1)
	call_deferred("queue_free")
