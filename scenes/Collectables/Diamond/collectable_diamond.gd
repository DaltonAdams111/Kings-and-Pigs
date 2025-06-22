extends Collectable
class_name CollectableDiamond


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_sound: AudioStreamPlayer2D = $CollisionSound
@onready var collection_sound: AudioStreamPlayer2D = $CollectionSound


func _on_collected(_body: Node2D, inventory: InventoryComponent) -> void:
	inventory.add_item(item, 1)
	collection_sound.pitch_scale = randf_range(0.95, 1.05)
	animation_player.play("collect")


func _on_body_entered(_body: Node) -> void:
	collision_sound.pitch_scale = randf_range(0.95, 1.05)
	collision_sound.play()
