extends State


@export var player: Player
@export var animation_player: AnimationPlayer

var state_machine: PlayerStateMachine


func enter() -> void:
	player.highest_point = player.global_position
	animation_player.speed_scale = 1
	animation_player.play("fall")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	var gravity_multiplier: float = 0.80 if player.is_holding_jump else 1.1
	player.apply_gravity(delta, gravity_multiplier)
	player.move(delta, can_flip_sprite)

	if not player.is_on_floor():
		return
	
	player.lowest_point = player.global_position
	player.fall_distance = player.lowest_point.y - player.highest_point.y

	var is_landing: bool = player.fall_distance > player.FALL_DISTANCE_THRESHOLD
	
	if is_landing:
		change_state.emit("land")
	elif Input.is_action_pressed("attack") and player.can_attack:
		change_state.emit("attack")
	elif Input.is_action_pressed("jump") and player.can_jump:
		change_state.emit("jump")
	elif state_machine.player.direction:
		change_state.emit("run")
	else:
		change_state.emit("idle")
