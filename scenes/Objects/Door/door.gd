@tool
extends Area2D
class_name Door


## Door that allows traveling from one level to another.


## The path of the level scene this [Door] leads to.
@export var target_level_path: String = "":
	set(value):
		target_level_path = value
		$LevelLabel.text = value.get_slice("/", 4)

@onready var animation_player: AnimationPlayer = $AnimationPlayer

## Timer that calls [method close_door] once the timer times out.
@onready var door_open_timer: Timer = $DoorOpenTimer


func _ready() -> void:
	if not Engine.is_editor_hint():
		$LevelLabel.hide()


func _input(event: InputEvent) -> void:
	if not target_level_path:
		return
	
	if not event.is_action_pressed("enter_door"):
		return
	
	var player: Player = Game.get_player()
	
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


## Plays the [Door]'s "opening" animation and starts its [member door_open_timer].
func open_door():
	animation_player.play("opening")
	door_open_timer.start()


## Plays the [Door]'s "closing" animation and queues the "idle" animation.
func close_door():
	animation_player.play("closing")
	animation_player.queue("idle")


func _on_door_open_timer_timeout() -> void:
	close_door()
