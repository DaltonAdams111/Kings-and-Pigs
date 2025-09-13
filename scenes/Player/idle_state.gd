extends State


@export var player: Player
@export var animation_player: AnimationPlayer

var state_machine: PlayerStateMachine


func enter() -> void:
	animation_player.speed_scale = 1
	animation_player.play("idle")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.move(delta, can_flip_sprite)
	
	if Input.is_action_pressed("attack") and player.can_attack:
		change_state.emit("attack")
	elif Input.is_action_just_pressed("jump") and player.can_jump:
		change_state.emit("jump")
	elif player.is_falling:
		change_state.emit("fall")
	elif player.direction:
		change_state.emit("run")
