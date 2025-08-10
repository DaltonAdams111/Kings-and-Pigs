extends StateMachine


@export var enemy: Pig
@export var animation_player: AnimationPlayer


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


func enter() -> void:
	processing_enabled = true


func exit() -> void:
	processing_enabled = false


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
