extends State


var enemy: Pig

const MAX_WANDER_DISTANCE: float = 50
const MIN_WANDER_DISTANCE: float = 25
const IDLE_TIME_SEC: float = 5.0
@onready var idle_timer: Timer = $IdleTimer


func _enter_tree() -> void:
	enemy = owner as Pig


func enter() -> void:
	enemy.target_position = get_random_position()


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.decelerate(delta)
	enemy.move(delta)
	
	if not enemy.direction and idle_timer.is_stopped():
		idle_timer.start(IDLE_TIME_SEC)
	
	if enemy.player_detected:
		enemy.dialogue_player.show_dialogue("Alert")
		change_state.emit("chase")
	

func get_random_position() -> Vector2:
	var distance: float = randf_range(MIN_WANDER_DISTANCE, MAX_WANDER_DISTANCE)
	var direction: int = 1 if randi_range(0, 1) == 1 else -1
	var position: Vector2 = enemy.global_position + Vector2(distance * direction, enemy.global_position.y)
	return position


func _on_idle_timer_timeout() -> void:
	if enemy.state_machine.current_state.name == name:
		enemy.target_position = get_random_position()
