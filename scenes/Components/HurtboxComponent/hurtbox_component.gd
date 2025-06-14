extends Area2D
class_name HurtboxComponent


## Component that manages the hit collision of an object.


## Emitted when an [AttackComponent] collides with this [HurtboxComponent].
signal hit(damage_amount: int)

@onready var invulnerable_timer: Timer = $InvulnerableTimer

## The number of seconds this [HurtboxComponent] will be invulnerable after being hit.
@export var invulnerable_time_sec: float = 0.0

## If this [HurtboxComponent] can currently be hurt.
var can_take_damage: bool = true

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
	if area is AttackComponent and can_take_damage:
		hit.emit(area.attack_damage)
		can_take_damage = false
		invulnerable_timer.start(invulnerable_time_sec)


func _on_invulnerable_timer_timeout() -> void:
	can_take_damage = true
