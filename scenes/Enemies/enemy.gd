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
@onready var state_machine: StateMachine = $StateMachine
@onready var inventory_component: InventoryComponent = $InventoryComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var attack_component: AttackComponent = $AttackComponent
@onready var object_collision_ray_cast: RayCast2D = $ObjectCollisionRayCast
@onready var player_detection_area: Area2D = $PlayerDetectionArea
@onready var player_detection_timer: Timer = $PlayerDetectionTimer

@export var movement_speed: float = 0.0
@export var acceleration: float = 0.0
@export var deceleration: float = 0.0

var direction: float = 0.0:
	set(value):
		direction = value
		if direction and sign(direction) != sign(facing_direction):
			flip()
var facing_direction: Direction = Direction.RIGHT

@export var attack_cooldown: float = 1.0
var can_attack: bool = true

var target_position: Vector2
@export var player_detection_timeout_sec: int = 0
var player_detected: bool = false
var player_position: Vector2


func _process(_delta: float) -> void:
	move_and_slide()


func _physics_process(_delta: float) -> void:
	if player_detected:
		player_position = Game.get_player().global_position


func flip() -> void:
	sprite_2d.flip_h = not sprite_2d.flip_h
	sprite_2d.offset.x = -sprite_2d.offset.x
	facing_direction = -facing_direction as Direction
	attack_component.position.x = -attack_component.position.x
	object_collision_ray_cast.target_position.x = -object_collision_ray_cast.target_position.x
	player_detection_area.position.x = -player_detection_area.position.x


func apply_gravity(delta: float, gravity_multiplier: float = 1.0):
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_multiplier


func decelerate(delta: float) -> void:
	if direction:
		return
	
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta * 0.8)


func move(delta: float) -> void:
	if animation_player.current_animation == "hit":
		return
	elif velocity.x and not animation_player.current_animation == "hit":
		animation_player.play("run")
	else:
		animation_player.play("idle")
	
	if object_collision_ray_cast.is_colliding():
		target_position.x -= facing_direction
		
	if not target_position:
		decelerate(delta)
		return
	
	var distance_to_target = global_position.x - target_position.x
	if absf(distance_to_target) < 1:
		target_position = Vector2.ZERO
		direction = 0.0
		return
	
	var target_direction: Vector2 = global_position.direction_to(target_position)
	
	direction = sign(target_direction.x)
	if direction:
		velocity.x = move_toward(velocity.x, movement_speed * direction, acceleration * delta)


func _on_attack_cooldown_timer_timeout() -> void:
	can_attack = true


func _on_player_detection_area_body_entered(_body: Node2D) -> void:
	player_detected = true
	player_detection_timer.stop()


func _on_player_detection_area_body_exited(_body: Node2D) -> void:
	player_detection_timer.start(player_detection_timeout_sec)


func _on_player_detection_timer_timeout() -> void:
	player_detected = false


func _on_hurtbox_component_hit(_damage_amount: int) -> void:
	animation_player.play("hit")
	animation_player.queue("idle")


func _on_health_component_health_depleted() -> void:
	state_machine.change_to_state("dead")
