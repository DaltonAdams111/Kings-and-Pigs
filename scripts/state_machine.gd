extends Node
class_name StateMachine

## Manages a collection of states.


## Initial State to start in upon loading the scene.
@export var default_state: State


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
func change_state(new_state_name: String, override: bool = false) -> void:
	if not states.has(new_state_name.to_lower()):
		return
	
	var new_state: State = states[new_state_name.to_lower()]
	
	if new_state == current_state and not override:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
