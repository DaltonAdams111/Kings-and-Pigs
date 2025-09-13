extends State
class_name StateMachine

## Manages a collection of states.


## Initial State to start in upon loading the scene.
@export var default_state: State

## If [code]true[/code], this [StateMachine] has its processing enabled.[br][br]
var processing_enabled: bool = false:
	set(value):
		processing_enabled = value
		
		if processing_enabled:
			set_process(true)
			set_physics_process(true)
		else:
			set_process(false)
			set_physics_process(false)

## Dictionary of available States.[br]
## [br]
## Access using the state's name.
## [codeblock]
## func _ready():
##     var run_state: State = states["run"]
## [/codeblock]
var states: Dictionary[String, State]

## Current active State.
var current_state: State
var previous_state: State


## Returns all child State nodes as a Dictionary.[br]
## [codeblock]
## func _ready():
##     states = get_states()
## [/codeblock]
func get_states() -> Dictionary[String, State]:
	var child_states: Dictionary[String, State]
	
	var children: Array[Node] = get_children()
	for child in children:
		if child is State:
			var key: String = child.name.to_lower()
			child_states[key] = child
	return child_states


## Changes the current active State.
func change_to_state(new_state_name: String, override: bool = false) -> void:
	if not states.has(new_state_name.to_lower()):
		return
	
	var new_state: State = states[new_state_name.to_lower()]
	
	if new_state == current_state and not override:
		return
	
	if current_state:
		current_state.exit()
		previous_state = current_state
	
	new_state.enter()
	
	current_state = new_state
