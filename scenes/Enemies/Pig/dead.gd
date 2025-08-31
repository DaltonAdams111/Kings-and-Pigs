extends State


var enemy: Pig


func _enter_tree() -> void:
	enemy = owner as Pig


func enter() -> void:
	if not enemy.animation_player.animation_finished.is_connected(_on_animation_finished):
		enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
	enemy.attack_component.set_deferred("monitoring", false)
	enemy.hurtbox_component.set_deferred("monitoring", false)
	enemy.player_detection_area.set_deferred("monitoring", false)
	enemy.direction = 0.0
	enemy.target_position = Vector2.ZERO
	enemy.animation_player.play("dead")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.decelerate(delta)


func _on_animation_finished(_animation: String):
	pass
