extends Enemy
class_name Pig

## Pig Enemy

@onready var attack_collision_shape_2d: CollisionShape2D = $AttackComponent/CollisionShape2D

const SPRITE_OFFSET_X: float = 3.0
const ATTACK_AREA_OFFSET_X: float = 14.0

var flip: bool = false:
	set(value):
		flip = value
		sprite_2d.flip_h = not flip
		if flip:
			sprite_2d.offset.x = -SPRITE_OFFSET_X
			attack_collision_shape_2d.position.x = -ATTACK_AREA_OFFSET_X
		else:
			sprite_2d.offset.x = SPRITE_OFFSET_X
			attack_collision_shape_2d.position.x = ATTACK_AREA_OFFSET_X


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("enter_door"):
		return
	
	flip = not flip
