extends RigidBody2D
class_name Collectable


signal collected(body: Node2D, inventory: InventoryComponent)

@onready var collectable_component: CollectableComponent = $CollectableComponent

@export var item: Item


func _on_collectable_component_collected(body: Node2D, inventory: InventoryComponent) -> void:
	collected.emit(body, inventory)
