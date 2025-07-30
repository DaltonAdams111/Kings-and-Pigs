extends Collectable
class_name CollectableDiamond


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_sound: AudioStreamPlayer2D = $CollisionSound
@onready var collection_sound: AudioStreamPlayer2D = $CollectionSound


func _on_collected(_body: Node2D, inventory: InventoryComponent) -> void:
	inventory.add_item(item, 1)
	collection_sound.pitch_scale = randf_range(0.98, 1.02)
	animation_player.play("collect")


func _on_body_entered(_body: Node) -> void:
	if not is_spawned and not collect_delay_timer.is_stopped():
		return
	
	collision_sound.pitch_scale = randf_range(0.98, 1.02)
	collision_sound.play()
