extends State


@export var enemy: Pig
@export var animation_player: AnimationPlayer


func enter() -> void:
	animation_player.play("run")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	enemy.apply_gravity(delta)
	
	if not enemy.direction:
		change_state.emit("Idle")
