extends Node

var layer: CanvasLayer
var panel: Panel
var label: Label
var timer: Timer


func _ready() -> void:
	_build_feedback_ui()


func show_feedback(text: String, duration := 1.4) -> void:
	if text.is_empty():
		return

	_ensure_feedback_ui()
	label.text = text
	panel.visible = true
	timer.stop()
	timer.wait_time = duration
	timer.start()


func _build_feedback_ui() -> void:
	layer = CanvasLayer.new()
	layer.layer = 20
	add_child(layer)

	panel = Panel.new()
	panel.visible = false
	panel.anchor_left = 0.5
	panel.anchor_right = 0.5
	panel.anchor_top = 0.0
	panel.anchor_bottom = 0.0
	panel.offset_left = -180.0
	panel.offset_right = 180.0
	panel.offset_top = 18.0
	panel.offset_bottom = 58.0
	layer.add_child(panel)

	var margin := MarginContainer.new()
	margin.anchor_right = 1.0
	margin.anchor_bottom = 1.0
	margin.offset_left = 10.0
	margin.offset_right = -10.0
	margin.offset_top = 6.0
	margin.offset_bottom = -6.0
	panel.add_child(margin)

	label = Label.new()
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	margin.add_child(label)

	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


func _ensure_feedback_ui() -> void:
	if not is_instance_valid(layer) or not is_instance_valid(panel) or not is_instance_valid(label) or not is_instance_valid(timer):
		_build_feedback_ui()


func _on_timer_timeout() -> void:
	if is_instance_valid(panel):
		panel.visible = false
