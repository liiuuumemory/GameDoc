extends CanvasLayer

signal option_selected(option: Dictionary)
signal close_requested

@onready var speaker_label: Label = %SpeakerLabel
@onready var body_label: Label = %BodyLabel
@onready var options_box: VBoxContainer = %OptionsBox


func request_close() -> void:
	close_requested.emit()


func show_node(speaker: String, text: String, options: Array) -> void:
	speaker_label.text = speaker
	body_label.text = text

	for child in options_box.get_children():
		child.queue_free()

	for option in options:
		var button := Button.new()
		button.text = option.get("text", "继续")
		button.custom_minimum_size = Vector2(0, 24)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.pressed.connect(func() -> void:
			option_selected.emit(option)
		)
		options_box.add_child(button)


func _on_close_button_pressed() -> void:
	request_close()
