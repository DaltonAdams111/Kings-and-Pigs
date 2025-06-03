extends Area2D
class_name CollectableComponent


## Component that enables objects to be collected.


@export_group("Collision", "collision")
## The physics layers this [CollectableComponent] checks for.
@export_flags_2d_physics var collision_masks: int


func _ready() -> void:
	if collision_masks:
		collision_mask = collision_masks
