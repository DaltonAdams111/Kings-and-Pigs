extends StateMachine


func _ready() -> void:
	states = get_states()
	
	for state in states:
		states[state].change_state.connect(change_to_state)
	
	if default_state:
		change_to_state(default_state.name)


func _process(delta: float) -> void:
	if not current_state:
		return
	
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	if not current_state:
		return
	
	current_state.physics_update(delta)
