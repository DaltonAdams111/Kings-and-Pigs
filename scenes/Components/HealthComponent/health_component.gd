extends Node
class_name HealthComponent


## Component that manages the health of an object.


## Emitted when the [member current_health] changes.
signal health_changed(new_health: int)

@export_group("Hit Detection")
## [HurtboxComponent] to detect collisions.
@export var hurtbox: HurtboxComponent

@export_group("Health")
## The maximum health for this [member HealthComponent].
@export_range(0, 100, 1.0) var MAX_HEALTH: int = 1

## The maximum damage this [member HealthComponent] can take in a single instance.
@export_range(0, 100, 1.0) var DAMAGE_CLAMP: int = 1

## The current health of this [member HealthComponent].
@onready var current_health: int = MAX_HEALTH:
	set(value):
		var new_health: int = clampi(value, 0, MAX_HEALTH)
		if new_health != current_health:
			current_health = new_health
			health_changed.emit(current_health)


func _ready() -> void:
	if hurtbox:
		hurtbox.connect("hit", damage)


## Removes health from this [member HealthComponent],
## clamping the [param damage_amount] to a maximum defined by [member DAMAGE_CLAMP],
## then subtracts the adjusted [param damage_amount] from the [member current_health].[br][br]
## Will not heal if a negative value is provided; see [method heal] instead.
func damage(damage_amount: int) -> void:
	var adjusted_damage: int = clampi(damage_amount, 0, DAMAGE_CLAMP)
	current_health -= adjusted_damage


## Restores health to this [member HealthComponent],
## adding the [param heal_amount] to the [member current_health].[br][br]
## Will not damage if a negative value is provided; see [method damage] instead.
func heal(heal_amount: int) -> void:
	var adjusted_heal: int = heal_amount if heal_amount > 0 else 0
	current_health += adjusted_heal
