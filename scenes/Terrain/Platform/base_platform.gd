extends StaticBody2D
class_name Platform


## Class for managing platforms.


@export_group("Collision")
## The physics layers this [member Platform] is on.
@export_flags_2d_physics var collision_layers: int

## If [code]true[/code], this [member Platform]'s [member CollisionShape2D] has one-way collision.
@export var has_one_way_collision: bool = false

## The [member CollisionShape2D] of this [member Platform].
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	if collision_layers:
		collision_layer = collision_layers
	
	if has_one_way_collision:
		collision_shape_2d.one_way_collision = has_one_way_collision
