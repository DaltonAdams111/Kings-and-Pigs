extends Enemy
class_name Pig

## Pig Enemy

@onready var attack_collision_shape_2d: CollisionShape2D = $AttackComponent/CollisionShape2D


func flip() -> void:
	super.flip()
	attack_collision_shape_2d.position.x = -attack_collision_shape_2d.position.x


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter_door"):
		flip()
	
	if event.is_action_pressed("attack") and can_attack:
		can_attack = false
		animation_player.play("attack")
		attack_cooldown_timer.start()
		animation_player.queue("idle")
	
	
