extends State


@export var player: Player
@export var animation_player: AnimationPlayer

var state_machine: PlayerStateMachine


func enter() -> void:
	if not animation_player.animation_finished.is_connected(on_animation_finished):
		animation_player.animation_finished.connect(on_animation_finished)


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	player.apply_gravity(delta)


func on_animation_finished(_animation: String):
	pass
