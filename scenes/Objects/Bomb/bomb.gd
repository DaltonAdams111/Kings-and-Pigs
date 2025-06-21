extends PhysicsObject
class_name Bomb


## The number of seconds this bomb waits before it explodes.
@export var explosion_delay_sec: float = 0.0


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var explosion_delay_timer: Timer = $ExplosionDelayTimer
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var attack_component: AttackComponent = $AttackComponent


func _ready() -> void:
	explosion_delay_timer.start(explosion_delay_sec)
	animation_player.play("lit")


func _on_hurtbox_component_area_entered(area: Area2D) -> void:
	if area is AttackComponent:
		var impulse_direction: Vector2 = area.owner.global_position.direction_to(global_position)
		var impulse_force: float = 200
		
		apply_central_impulse((impulse_direction + Vector2(0.0, -0.5)) * impulse_force)


func _on_explosion_delay_timer_timeout() -> void:
	animation_player.play("explode")
