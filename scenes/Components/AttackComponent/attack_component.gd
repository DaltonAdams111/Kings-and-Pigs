@tool
extends Area2D
class_name AttackComponent


## Component that manages the attack collision and attack damage of an object.


@export_group("Attack", "attack")
## The amount of damage this [AttackComponent] deals.
@export_range(0, 100, 1.0) var attack_damage: int

@export_group("Attack Collision")
@export_subgroup("Attack Owner", "owner_")
## The physics layer this [AttackComponent] is on.
@export_flags("Player:2", "Enemy:32", "Object:512")
var owner_collision: int = 0:
	set(value):
		if value == 0:
			owner_collision = value
		elif owner_collision:
			owner_collision = absi(owner_collision - value)
		else:
			owner_collision = value

@export_subgroup("Can Attack", "can_attack_")
## The physics layers this [AttackComponent] can hurt.
@export_flags("Player:4", "Enemy:64", "Object:1024")
var can_attack_collision: int = 0


func _ready() -> void:
	if owner_collision:
		collision_layer = owner_collision
	
	if can_attack_collision:
		collision_mask = can_attack_collision
