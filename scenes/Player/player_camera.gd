extends Camera2D
class_name PlayerCamera

@onready var player: Player = $".."

var RNG = RandomNumberGenerator.new()

var current_shake_strength: float = 0.0
var current_fade_strength: float = 0.0


func _process(delta: float) -> void:
	if current_shake_strength > 0:
		current_shake_strength = lerpf(current_shake_strength, 0, current_fade_strength * delta)
	
		offset = random_offset()


## Will cause the camera to shake. Use [param shake_strength] to set the intensity of the shake,
## and set how quickly the shake will end using [param fade_strength].
func shake(shake_strength: float = 1.0, fade_strength: float = 1.0) -> void:
	current_shake_strength = shake_strength
	current_fade_strength = fade_strength


func random_offset() -> Vector2:
	return Vector2(RNG.randf_range(-current_shake_strength, current_shake_strength), RNG.randf_range(-current_shake_strength, current_shake_strength))
