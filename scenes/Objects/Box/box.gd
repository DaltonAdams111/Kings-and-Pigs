extends PhysicsObject
class_name Box


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var inventory_component: InventoryComponent = $InventoryComponent

@export var possible_items: Array[Item] = []
@export var possible_number_of_items: int = 0
var number_of_items: int = 0


func _ready() -> void:
	randomize()
	number_of_items = randi_range(0, possible_number_of_items)
	randomize_items()
	inventory_component.consolidate_items()


func randomize_items() -> void:
	for item in number_of_items:
		randomize()
		inventory_component.add_item(possible_items[randi() % len(possible_items)])


func _on_hurtbox_component_hit(_damage_amount: int) -> void:
	animated_sprite_2d.play("hit")
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play("idle")
	if health_component.current_health == 0:
		queue_free()


func _on_health_component_health_depleted() -> void:
	inventory_component.spawn_all_items(global_position)
