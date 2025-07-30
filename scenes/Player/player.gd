extends CharacterBody2D
class_name  Player


## Player Character


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var attack_collision_shape_2d: CollisionShape2D = $AttackComponent/CollisionShape2D
@onready var floor_ray_cast: RayCast2D = $FloorRayCast
@onready var door_ray_cast: RayCast2D = $DoorRayCast
@onready var player_camera: PlayerCamera = $PlayerCamera
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer
@onready var player_ui: PlayerUI = $PlayerUI
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine

## [InventoryComponent] for managing the player's inventory.
@onready var inventory_component: InventoryComponent = $InventoryComponent
## [HealthComponent] for managing the player's health.
@onready var health_component: HealthComponent = $HealthComponent
## [HurtboxComponent] for detecting collisions from attacks and updating the player's [member health_component].
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
## [AttackComponent] for defining the player's attack area and attack damage.
@onready var attack_component: AttackComponent = $AttackComponent

## Valid [State](s) that the player can enter doors from.
@export var enter_door_states: Array[State] = []


const SPRITE_OFFSET_X: float = 7.0
const ATTACK_AREA_POSITION_X: float = 32.0


const MOVEMENT_SPEED: float = 150.0
const ACCELERATION: float = 750.0
const DECELERATION: float = 700.0
const JUMP_VELOCITY: float = 225.0
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


func _ready() -> void:
	update_health_ui()
	update_diamonds_ui()


func _process(_delta: float) -> void:
	move_and_slide()


func _physics_process(delta: float) -> void:
	decelerate(delta)
	handle_collisions()
	
	can_attack = attack_cooldown_timer.is_stopped()
	can_jump = is_on_floor()
	is_falling = not is_on_floor() and velocity.y > 0
	is_holding_jump = Input.is_action_pressed("jump")
	can_enter_door = is_on_floor() and state_machine.current_state in enter_door_states


func decelerate(delta: float):
	if direction:
		return
	
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta * 0.8)


func move(delta: float, flip_sprite: bool = false) -> void:
	if can_fall_through_platform() and Input.is_action_pressed("move_down"):
		position.y += 1.25
	
	direction = Input.get_axis("move_left", "move_right")
	
	if not direction:
		return
	
	var opposite_direction: bool = direction and velocity.x != 0 and sign(direction) != sign(velocity.x)
	var acceleration_multiplier: float = 2.0 if (opposite_direction and is_on_floor()) else 1.0
	
	velocity.x = move_toward(velocity.x, MOVEMENT_SPEED * direction, ACCELERATION * delta * acceleration_multiplier)
	
	if not flip_sprite:
		return
	
	if direction > 0:
		sprite_2d.flip_h = false
		sprite_2d.offset.x = SPRITE_OFFSET_X
		attack_collision_shape_2d.position.x = ATTACK_AREA_POSITION_X
	elif direction < 0:
		sprite_2d.flip_h = true
		sprite_2d.offset.x = -SPRITE_OFFSET_X
		attack_collision_shape_2d.position.x = -ATTACK_AREA_POSITION_X


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


func handle_collisions() -> void:
	if is_on_floor_only():
		return
	
	for count in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(count)
		if collision.get_collider() is Bomb:
			var bomb: Bomb = collision.get_collider()
			var push_direction: Vector2 = -collision.get_normal()
			var push_force: float = 20.0 + velocity.x
			
			bomb.apply_central_impulse(push_direction * push_force)


func update_diamonds_ui() -> void:
	var diamond_slot: ItemSlot = inventory_component.find_item_name("Diamond")
	if diamond_slot:
		player_ui.update_diamonds(diamond_slot.item_count)
	else:
		player_ui.update_diamonds(0)
	
	for slot in inventory_component.inventory:
		print("%s_%d: %d"%[slot.item.name, inventory_component.inventory.find(slot), slot.item_count])


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("test_action"):
		return
	
	if inventory_component.is_empty:
		return
	
	var item: Item = inventory_component.inventory[0].item
	if item:
		inventory_component.spawn_items(item, global_position + Vector2(0, -25))

func _on_health_component_health_changed(_new_health: int) -> void:
	update_health_ui()


func _on_inventory_component_inventory_changed() -> void:
	update_diamonds_ui()


func update_health_ui() -> void:
	player_ui.update_hearts(health_component.current_health)


func _on_hurtbox_component_hit(_damage_amount: int) -> void:
	state_machine.change_state("hit")
