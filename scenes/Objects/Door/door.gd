extends Area2D
class_name Door


@export var target_level_path: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var door_open_timer: Timer = $DoorOpenTimer


func open_door():
	animation_player.play("opening")
	door_open_timer.start()


func close_door():
	animation_player.play("closing")
	animation_player.queue("idle")


func _on_door_open_timer_timeout() -> void:
	close_door()
