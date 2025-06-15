extends Level


@onready var jump_label: Label = $JumpLabel


func _ready() -> void:
	var jump_key: String = InputMap.action_get_events("jump")[0].as_text().get_slice(" ", 0)
	jump_label.text = jump_label.text.replace("INPUT", str(jump_key))
