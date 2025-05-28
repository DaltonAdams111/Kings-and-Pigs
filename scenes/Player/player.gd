extends CharacterBody2D
class_name  Player


## Player


signal door_entered(door: Door)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $AttackComponent/CollisionShape2D
@onready var floor_ray_cast: RayCast2D = $FloorRayCast
@onready var door_ray_cast: RayCast2D = $DoorRayCast
@onready var player_camera: PlayerCamera = $PlayerCamera
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer
@onready var player_ui: CanvasLayer = $PlayerUI

@onready var state_machine: PlayerStateMachine = $StateMachine

@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var attack_component: AttackComponent = $AttackComponent


const SPRITE_OFFSET_X: float = 7.0
const ATTACK_AREA_POSITION_X: float = 32.0


const MOVEMENT_SPEED: float = 150.0
const ACCELERATION: float = 750.0
const DECELERATION: float = 700.0
const JUMP_VELOCITY: float = 175.0
var direction: float = 0.0

const ATTACK_COOLDOWN: float = 0.4

const FALL_DISTANCE_THRESHOLD: float = 100.0
var fall_distance: float = 0.0
var highest_point: Vector2 = Vector2.ZERO
var lowest_point: Vector2 = Vector2.ZERO

var can_attack: bool = false
var can_jump: bool = false
var is_falling: bool = false
var is_holding_jump: bool = false
var can_enter_door: bool = false
var door: Door = null


func _process(_delta: float) -> void:
	move_and_slide()


func _physics_process(delta: float) -> void:
	decelerate(delta)
	
	can_attack = attack_cooldown_timer.is_stopped()
	can_jump = is_on_floor()
	is_falling = not is_on_floor() and velocity.y > 0
	is_holding_jump = Input.is_action_pressed("jump")
	can_enter_door = is_on_floor()
	door = door_ray_cast.get_collider()


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("enter_door"):
		return
	
	if not door:
		return
	
	if not door.target_level_path:
		return
	
	if not can_enter_door:
		return
	
	velocity = Vector2.ZERO
	global_position = door.global_position
	door.open_door()
	state_machine.change_state("doorin")


func decelerate(delta: float):
	if direction:
		return
	
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta * 0.8)


func move(delta: float, flip_sprite: bool = false) -> void:
	if can_fall_through_platform() and Input.is_action_pressed("move_down"):
		position.y += 1
	
	direction = Input.get_axis("move_left", "move_right")
	
	if not direction:
		return
	
	var opposite_direction: bool = direction and velocity.x != 0 and sign(direction) != sign(velocity.x)
	var acceleration_multiplier: float = 2 if (opposite_direction and is_on_floor()) else 1
	
	velocity.x = move_toward(velocity.x, MOVEMENT_SPEED * direction, ACCELERATION * delta * acceleration_multiplier)
	
	if not flip_sprite:
		return
	
	if direction > 0:
		sprite_2d.flip_h = false
		sprite_2d.offset.x = SPRITE_OFFSET_X
		collision_shape_2d.position.x = ATTACK_AREA_POSITION_X
	elif direction < 0:
		sprite_2d.flip_h = true
		sprite_2d.offset.x = -SPRITE_OFFSET_X
		collision_shape_2d.position.x = -ATTACK_AREA_POSITION_X


func apply_gravity(delta: float, gravity_multiplier: float = 1.0):
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_multiplier


func can_fall_through_platform() -> bool:
	if not floor_ray_cast.is_colliding():
		return false
	
	if not floor_ray_cast.get_collider() is Platform:
		return false
	
	if not (floor_ray_cast.get_collider() as Platform).has_one_way_collision:
		return false
	
	return true


func player_entered_door():
	door_entered.emit(door)
