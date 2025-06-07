extends RigidBody2D
class_name Crate


@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var inventory_component: InventoryComponent = $InventoryComponent
@export var item: Item


func _on_health_component_health_changed(new_health: int) -> void:
	print("%s's new health: %d" %[name, new_health])


func _on_hurtbox_component_hit(damage_amount: int) -> void:
	print("%s was hit for %d damage" %[name, damage_amount])


func _on_health_component_health_depeted() -> void:
	inventory_component.spawn_items(inventory_component.find_item_name("Diamond").item, global_position, -1)
	health_component.heal(health_component.MAX_HEALTH)
	inventory_component.add_item(item, 5)
