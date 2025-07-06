@tool
extends Area2D
class_name Door


## Door that allows traveling from one level to another.


var game: Game

## If [code]true[/code], the [Player] can interact with this door.
@export var interactable: bool = false:
	set(value):
		interactable = value
		$CollisionShape2D.disabled = not interactable
		notify_property_list_changed()

## The path of the level scene this [Door] leads to.
var target_level_path: String = "":
	set(value):
		target_level_path = value
		$LevelLabel.text = value.get_slice("/", 4)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var door_open_timer: Timer = $DoorOpenTimer


func _ready() -> void:
	if not Engine.is_editor_hint():
		$LevelLabel.hide()
	
	game = get_tree().root.find_child("Game", true, false)


func _input(event: InputEvent) -> void:
	if not interactable:
		return
	
	if not target_level_path:
		return
	
	if not event.is_action_pressed("enter_door"):
		return
	
	var player: Player = Globals.player
	
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
	
	game.level_transition(target_level_path)


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


#region Custom Property List
func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	if interactable:
		properties.append({
			"name": "target_level_path",
			"type": TYPE_STRING,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_NONE,
			"hint_string": ""
		})
	else:
		target_level_path = ""
	
	return properties


func _property_can_revert(property: StringName) -> bool:
	if property == "interactable":
		return true
	if property == "target_level_path":
		return true
	return false


func _property_get_revert(property: StringName) -> Variant:
	if property == "interactable":
		return false
	if property == "target_level_path":
		return ""
	return
#endregion
