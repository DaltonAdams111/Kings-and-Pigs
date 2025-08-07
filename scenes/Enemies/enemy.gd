extends CharacterBody2D
class_name Enemy


## Enemy Class


enum Direction {
	LEFT = -1,
	RIGHT = 1,
}

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $StateMachine
@onready var inventory_component: InventoryComponent = $InventoryComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var attack_component: AttackComponent = $AttackComponent

var facing_direction: Direction = Direction.RIGHT

@export var attack_cooldown: float = 1.0
var can_attack: bool = true


func flip() -> void:
	sprite_2d.flip_h = not sprite_2d.flip_h
	sprite_2d.offset.x = -sprite_2d.offset.x
	facing_direction = -facing_direction as Direction


func _on_attack_cooldown_timer_timeout() -> void:
	can_attack = true
