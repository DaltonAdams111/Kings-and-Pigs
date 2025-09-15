extends Node


signal input_device_changed(new_device: InputDevice)


enum InputDevice {
	KEYBOARD_MOUSE,
	XBOX,
	SONY,
}


var input_device: int = InputDevice.KEYBOARD_MOUSE:
	set(value):
		if input_device == value:
			return
		
		input_device = value
		input_device_changed.emit(input_device)


func get_action_key(action: StringName, device: int = input_device) -> String:
	var action_event: InputEvent = get_action_event(action, device)
	var device_name: String = get_device_name(device)
	var action_button: String = action_event.as_text().replace(" (Physical)", "") if device == InputDevice.KEYBOARD_MOUSE else action_event.as_text().get_slice(device_name, 1).get_slice(",", 0).trim_prefix(" ")
	return action_button


func get_action_event(action: StringName, device: int = input_device) -> InputEvent:
	var event = InputMap.action_get_events(action)[0 if device == InputDevice.KEYBOARD_MOUSE else 1]
	return event


func get_device_name(device: int = input_device) -> String:
	var device_name: String = String(InputDevice.find_key(device)).capitalize()
	return device_name


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		input_device = InputDevice.KEYBOARD_MOUSE
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		var joy_name: String = Input.get_joy_name(0)
		input_device = InputDevice.XBOX if joy_name.contains("Xbox") else InputDevice.SONY
