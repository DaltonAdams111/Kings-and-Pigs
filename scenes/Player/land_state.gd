extends State


@export var player: Player
@export var animation_player: AnimationPlayer

var state_machine: PlayerStateMachine


func enter() -> void:
	if not animation_player.animation_finished.is_connected(on_animation_finished):
		animation_player.animation_finished.connect(on_animation_finished)
	
	animation_player.speed_scale = 1
	animation_player.play("land")
	player.velocity.x = 0
	player.player_camera.shake((player.fall_distance / player.FALL_DISTANCE_THRESHOLD) / 2, 5.0)
	player.fall_distance = 0.0


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func on_animation_finished(_animation: String):
	if Input.is_action_pressed("attack") and player.can_attack:
		change_state.emit("attack")
	elif Input.is_action_just_pressed("jump") and player.can_jump:
		change_state.emit("jump")
	elif player.is_falling:
		change_state.emit("fall")
	elif player.direction:
		change_state.emit("run")
	else:
		change_state.emit("idle")
