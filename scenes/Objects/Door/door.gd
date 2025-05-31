extends Area2D
class_name Door


@export var target_level_path: String

@onready var player: Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var door_open_timer: Timer = $DoorOpenTimer


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


func _input(event: InputEvent) -> void:
	if not target_level_path:
		return
	
	if not event.is_action_pressed("enter_door"):
		return
	
	if not player in get_overlapping_bodies():
		return
	
	if not player.can_enter_door:
		return
	
	open_door()
	
	player.velocity = Vector2.ZERO
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(player, "global_position", global_position, 0.25)
	
	player.state_machine.change_state("doorin")
	await player.animation_player.animation_finished
	
	Game.level_transition(target_level_path)


func open_door():
	animation_player.play("opening")
	door_open_timer.start()


func close_door():
	animation_player.play("closing")
	animation_player.queue("idle")


func _on_door_open_timer_timeout() -> void:
	close_door()
