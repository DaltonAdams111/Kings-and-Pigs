extends State


@export var player: Player
@export var animation_player: AnimationPlayer

var state_machine: PlayerStateMachine


func enter() -> void:
	if not animation_player.animation_finished.is_connected(on_animation_finished):
		animation_player.animation_finished.connect(on_animation_finished)
	
	animation_player.play("door_out")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func on_animation_finished(_animation: String):
	change_state.emit("idle")
