extends Area2D
class_name AttackComponent


## Component that manages the attack collision of an object.


@export_group("Attack", "attack")
## The amount of damage this [member AttackComponent] deals.
@export_range(0, 100, 1.0) var attack_damage: int

@export_group("Collision", "collision")
## The physics layers this [member AttackComponent] is on.
@export_flags_2d_physics var collision_layers: int

## The physics layers this [member AttackComponent] checks for.
@export_flags_2d_physics var collision_masks: int


func _ready() -> void:
	if collision_layers:
		collision_layer = collision_layers
	
	if collision_masks:
		collision_mask = collision_masks
