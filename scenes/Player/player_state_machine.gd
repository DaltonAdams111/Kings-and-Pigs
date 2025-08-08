extends StateMachine
class_name PlayerStateMachine


@export var player: Player
@export var animation_player: AnimationPlayer


func _ready() -> void:
	states = get_states()
	
	for state in states:
		states[state].change_state.connect(change_to_state)
		states[state].state_machine = self
	
	if default_state:
		change_to_state(default_state.name, true)
	
	set_process(false)
	set_physics_process(false)


func _process(delta: float) -> void:
	if not current_state:
		return
	
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	if not current_state:
		return
	
	current_state.physics_update(delta)


func enter() -> void:
	set_process(true)
	set_physics_process(true)


func exit() -> void:
	set_process(false)
	set_physics_process(false)


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
