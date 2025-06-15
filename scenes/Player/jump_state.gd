extends State


@export var player: Player
@export var animation_player: AnimationPlayer

var state_machine: PlayerStateMachine


func enter() -> void:
	var bonus_height: float = -(absf(player.velocity.x) / 5)
	player.velocity.y = -player.JUMP_VELOCITY + bonus_height
	
	animation_player.speed_scale = 1
	animation_player.play("jump")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	var additional_jump_velocity: float = -5.0 if player.is_holding_jump else 5.0
	player.velocity.y += additional_jump_velocity
	player.apply_gravity(delta)
	player.move(delta, can_flip_sprite)

	if player.is_falling:
		change_state.emit("fall")
	elif player.is_on_floor():
		change_state.emit("idle")
