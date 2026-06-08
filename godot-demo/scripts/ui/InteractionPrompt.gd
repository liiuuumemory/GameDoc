extends CanvasLayer

@onready var label: Label = %PromptLabel


func show_prompt(text: String) -> void:
	visible = true
	label.text = "Press E - %s" % text


func hide_prompt() -> void:
	visible = false
