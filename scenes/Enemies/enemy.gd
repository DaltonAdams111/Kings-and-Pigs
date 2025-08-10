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

@export var jump_velocity: float = 0.0
@export var movement_speed: float = 0.0
@export var acceleration: float = 0.0

var direction: float = 0.0:
	set(value):
		direction = value
		if direction and sign(direction) != sign(facing_direction):
			flip()
var facing_direction: Direction = Direction.RIGHT

@export var attack_cooldown: float = 1.0
var can_attack: bool = true


func _process(_delta: float) -> void:
	move_and_slide()


func flip() -> void:
	sprite_2d.flip_h = not sprite_2d.flip_h
	sprite_2d.offset.x = -sprite_2d.offset.x
	facing_direction = -facing_direction as Direction


func apply_gravity(delta: float, gravity_multiplier: float = 1.0):
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_multiplier


func jump() -> void:
	if not is_on_floor():
		return
	
	velocity.y = jump_velocity


func move(delta, _target_position, _flip_sprite) -> void:
	velocity.x = move_toward(velocity.x, movement_speed * direction, acceleration * delta)
	print(velocity.x)


func attack() -> void:
	pass


func _on_attack_cooldown_timer_timeout() -> void:
	can_attack = true
