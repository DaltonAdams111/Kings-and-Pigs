extends Camera2D
class_name PlayerCamera

@onready var player: Player = $".."


var shake_strength: float = 2.5
var shake_fade: float = player.FALL_DISTANCE_THRESHOLD * 0.1
var RNG = RandomNumberGenerator.new()

var current_strength: float = 0.0
var current_fade: float = 0.0


func _process(delta: float) -> void:
	if current_strength > 0:
		current_strength = lerpf(current_strength, 0, current_fade * delta)
	
		offset = random_offset()

func shake(strength: float = shake_strength, fade: float = shake_fade) -> void:
	current_strength = strength
	current_fade = fade


func random_offset() -> Vector2:
	return Vector2(RNG.randf_range(-current_strength, current_strength), RNG.randf_range(-current_strength, current_strength))
