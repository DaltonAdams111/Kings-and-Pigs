extends Area2D
class_name CollectableComponent


## Component that enables objects to be collected.


signal collected(body: Node2D, inventory: InventoryComponent)

@export_group("Collision", "collision")
## The physics layers this [CollectableComponent] checks for.
@export_flags_2d_physics var collision_masks: int


func _ready() -> void:
	if collision_masks:
		collision_mask = collision_masks


func _on_body_entered(body: Node2D) -> void:
	var inventory: InventoryComponent = body.find_child("InventoryComponent")
	if inventory:
		collected.emit(body, inventory)
