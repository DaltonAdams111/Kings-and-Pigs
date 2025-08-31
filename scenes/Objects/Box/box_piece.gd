extends PhysicsObject
class_name BoxPiece


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const BOX_PIECES_1: Texture2D = preload("res://assets/08-Box/Box Pieces 1.png")
const BOX_PIECES_2: Texture2D = preload("res://assets/08-Box/Box Pieces 2.png")
const BOX_PIECES_3: Texture2D = preload("res://assets/08-Box/Box Pieces 3.png")
const BOX_PIECES_4: Texture2D = preload("res://assets/08-Box/Box Pieces 4.png")

const possible_pieces = [BOX_PIECES_1, BOX_PIECES_2, BOX_PIECES_3, BOX_PIECES_4]


func _ready() -> void:
	sprite_2d.texture = possible_pieces.pick_random()
	
	
	var velocity_magnitude: float = randf_range(150, 200)
	var impulse_velocity: Vector2 = Vector2.UP.rotated(randf_range(-0.75, 0.75)) * velocity_magnitude
	apply_central_impulse(impulse_velocity)
	
	var random_rotation: float = randf_range(-0.5, 0.5)
	rotate(random_rotation)
