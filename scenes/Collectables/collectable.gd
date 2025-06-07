extends RigidBody2D
class_name Collectable


signal collected(body: Node2D, inventory: InventoryComponent)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collectable_component: CollectableComponent = $CollectableComponent
@onready var collect_delay_timer: Timer = $CollectDelayTimer

@export var item: Item = null

@export_range(0.0, 10.0, 1) var collection_delay_sec: float = 1.0


func _ready() -> void:
	collectable_component.monitoring = false
	collect_delay_timer.start(collection_delay_sec)


func _on_collectable_component_collected(body: Node2D, inventory: InventoryComponent) -> void:
	collected.emit(body, inventory)


func _on_collect_delay_timer_timeout() -> void:
	animated_sprite_2d.play("idle")
	collectable_component.monitoring = true
