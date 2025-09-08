@tool
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

@export_group("Hurtbox Collision")
@export_subgroup("Hurtbox Owner", "owner_")
## The physics layer this [HurtboxComponent] is on.
@export_flags("Player:4", "Enemy:64", "Object:1024")
var owner_collision: int = 0:
	set(value):
		if value == 0:
			owner_collision = value
		elif owner_collision:
			owner_collision = absi(owner_collision - value)
		else:
			owner_collision = value

@export_subgroup("Attacked By", "attacked_by_")
## The physics layers this [HurtboxComponent] can be hurt by.
@export_flags("Player:2", "Enemy:32", "Object:512")
var attacked_by_collision: int = 0


func _ready() -> void:
	if owner_collision:
		collision_layer = owner_collision
	
	if attacked_by_collision:
		collision_mask = attacked_by_collision


func _on_area_entered(area) -> void:
	if not can_take_damage:
		return
	
	if not area is AttackComponent:
		return
	
	var attack_component: AttackComponent = area as AttackComponent
	
	var is_attacked_by_attacker: bool = owner_collision & attack_component.can_attack_collision
	if not is_attacked_by_attacker:
		return
	
	hit.emit(attack_component.attack_damage)
	can_take_damage = false
	invulnerable_timer.start(invulnerable_time_sec)


func _on_invulnerable_timer_timeout() -> void:
	can_take_damage = true
