extends State


var enemy: Pig


func _enter_tree() -> void:
	enemy = owner as Pig


func enter() -> void:
	if not enemy.animation_player.animation_finished.is_connected(_on_animation_finished):
		enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
	enemy.velocity = Vector2.ZERO
	enemy.can_attack = false
	enemy.animation_player.play("attack")
	enemy.attack_cooldown_timer.start(enemy.attack_cooldown_sec)


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func _on_animation_finished(_animation: String):
	if enemy.player_detected:
		change_state.emit("chase")
	else:
		change_state.emit("wander")
