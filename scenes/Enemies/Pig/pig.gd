extends Enemy
class_name Pig

## Pig Enemy

@onready var attack_collision_shape_2d: CollisionShape2D = $AttackComponent/CollisionShape2D


func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	move(delta, Vector2.ZERO,true)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump()


func flip() -> void:
	super.flip()
	attack_collision_shape_2d.position.x = -attack_collision_shape_2d.position.x


func move(delta, _target_position: Vector2, _flip_sprite: bool) -> void:
	super.move(delta, _target_position, _flip_sprite)
