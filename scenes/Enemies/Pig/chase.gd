extends State


var enemy: Pig


func _enter_tree() -> void:
	enemy = owner as Pig


func enter() -> void:
	pass


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.decelerate(delta)
	enemy.move(delta)
	
	if not enemy.player_detected:
		change_state.emit("wander")
	
	enemy.target_position = enemy.player_position
	if not enemy.player_in_melee_range:
		return
	enemy.target_position = enemy.global_position
	if enemy.can_attack:
		change_state.emit("attack")
