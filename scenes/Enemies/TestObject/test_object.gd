extends RigidBody2D
class_name Crate


@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var inventory_component: InventoryComponent = $InventoryComponent


func _on_health_component_health_changed(new_health: int) -> void:
	print("%s's new health: %d" %[name, new_health])


func _on_hurtbox_component_hit(damage_amount: int) -> void:
	print("%s was hit for %d damage" %[name, damage_amount])


func _on_health_component_health_depeted() -> void:
	inventory_component.spawn_all_items(global_position)


func _on_inventory_component_inventory_changed() -> void:
	if not len(inventory_component.inventory):
		queue_free()
