extends Area2D
class_name HurtboxComponent


## Component that manages the hit collision of an object.


## Emitted when an [AttackComponent] collides with this [HurtboxComponent].
signal hit(damage_amount: int)

@export_group("Collision", "collision")
## The physics layers this [HurtboxComponent] is on.
@export_flags_2d_physics var collision_layers: int

## The physics layers this [HurtboxComponent] checks for.
@export_flags_2d_physics var collision_masks: int


func _ready() -> void:
	if collision_layers:
		collision_layer = collision_layers
	
	if collision_masks:
		collision_mask = collision_masks


func _on_area_entered(area) -> void:
	if area is AttackComponent:
		hit.emit(area.attack_damage)
