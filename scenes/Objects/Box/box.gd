extends PhysicsObject
class_name Box


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var inventory_component: InventoryComponent = $InventoryComponent
@onready var attack_component: AttackComponent = $AttackComponent

@export var guaranteed_items: Array[ItemSlot] = []

@export var possible_items: Array[Item] = []
@export var possible_number_of_items: int = 0
var number_of_items: int = 0

const box_piece: PackedScene = preload("res://scenes/Objects/Box/box_piece.tscn")


func _ready() -> void:
	number_of_items = randi_range(0, possible_number_of_items)
	randomize_items()
	
	for itemslot: ItemSlot in guaranteed_items:
		inventory_component.add_item(itemslot.item, itemslot.item_count)
	inventory_component.consolidate_items()


func _physics_process(_delta: float) -> void:
	var velocity: Vector2 = linear_velocity.abs()
	if velocity.x or velocity.y > 100:
		attack_component.enable()
	else:
		attack_component.disable()


func randomize_items() -> void:
	for item in number_of_items:
		inventory_component.add_item(possible_items[randi() % len(possible_items)])


func _on_hurtbox_component_hit(_damage_amount: int) -> void:
	animated_sprite_2d.play("hit")


func _on_health_component_health_depleted() -> void:
	await inventory_component.spawn_all_items(global_position)
	for i in range(4):
		var piece: BoxPiece = box_piece.instantiate()
		Game.current_level.add_object(piece, global_position)
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	if health_component.current_health == 0:
		return
	animated_sprite_2d.play("idle")


func _on_attack_component_area_entered(_area: Area2D) -> void:
	health_component.damage(health_component.MAX_HEALTH)
