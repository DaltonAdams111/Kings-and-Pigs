extends RichTextLabel
class_name InputLabel


@export_multiline var input_label_text: String = ""
@export var input_actions: Array[String] = []


func _ready() -> void:
	var input_action_text: Array[String] = get_input_text()
	text = input_label_text % input_action_text
	
	DeviceManager.input_device_changed.connect(_on_input_device_changed)


func get_input_text() -> Array[String]:
	var input_text: Array[String] = []
	for action in input_actions:
		input_text.append(DeviceManager.get_action_key(action))
	return input_text


func _on_input_device_changed(_new_device: int) -> void:
	var input_action_text: Array[String] = get_input_text()
	text = input_label_text % input_action_text
