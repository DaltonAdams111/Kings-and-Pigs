extends RigidBody2D
class_name Crate


@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent


func _on_health_component_health_changed(new_health: int) -> void:
	print("%s's new health: %d" %[name, new_health])


func _on_hurtbox_component_hit(damage_amount: int) -> void:
	print("%s was hit for %d damage" %[name, damage_amount])
