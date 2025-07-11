extends Node
class_name HealthComponent


## Component that manages the health of an object.


## Emitted when the [member current_health] changes.
signal health_changed(new_health: int)

signal health_depleted

@export_group("Hit Detection")
## [HurtboxComponent] to detect collisions with [AttackComponent]s.
@export var hurtbox: HurtboxComponent

## If [code]true[/code], this [HealthComponent] will not take damage when [method damage] is called.
@export var invulnerable: bool = false

@export_group("Health")
## The maximum health for this [HealthComponent].
@export_range(0, 100, 1.0) var MAX_HEALTH: int = 1

## The maximum damage this [HealthComponent] can take in a single instance.
@export_range(0, 100, 1.0) var DAMAGE_CLAMP: int = 1

## The current health of this [HealthComponent].[br][br]
## Any changes to the [member current_health] will be clamped between 0, and [member DAMAGE_CLAMP].
@onready var current_health: int = MAX_HEALTH:
	set(value):
		var new_health: int = clampi(value, 0, MAX_HEALTH)
		if new_health != current_health:
			current_health = new_health
			health_changed.emit(current_health)
			if current_health == 0:
				health_depleted.emit()


func _ready() -> void:
	if hurtbox:
		hurtbox.connect("hit", damage)


## Removes health from this [HealthComponent],
## clamping the [param damage_amount] to a maximum defined by [member DAMAGE_CLAMP],
## then subtracts the adjusted [param damage_amount] from the [member current_health].[br][br]
## Will not heal if a negative value is provided; see [method heal] instead.
func damage(damage_amount: int) -> void:
	if invulnerable:
		return
	
	var adjusted_damage: int = clampi(damage_amount, 0, DAMAGE_CLAMP)
	current_health -= adjusted_damage


## Restores health to this [HealthComponent],
## adding the [param heal_amount] to the [member current_health].[br][br]
## Will not damage if a negative value is provided; see [method damage] instead.
func heal(heal_amount: int) -> void:
	var adjusted_heal: int = max(0, heal_amount)
	current_health += adjusted_heal
