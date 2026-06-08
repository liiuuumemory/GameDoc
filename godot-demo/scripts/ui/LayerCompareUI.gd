extends CanvasLayer

@onready var extra_label := get_node_or_null("Panel/MarginContainer/VBox/ExtraLabel") as Label


func _ready() -> void:
	if extra_label:
		extra_label.visible = int(GameState.get_flag("old_blocks_scan_count")) >= 3
	UIManager.register_popup(self)


func request_close() -> void:
	UIManager.close_popup(self)


func _on_draft_button_pressed() -> void:
	GameState.set_flag("discrepancy_note_drafted", true)
	GameState.set_flag("field_note_saved", true)
	_finish_layer_compare()
	FeedbackManager.show_feedback("偏差附录草稿已保存。目标更新。")
	UIManager.close_popup(self)


func _on_note_button_pressed() -> void:
	GameState.set_flag("field_note_saved", true)
	_finish_layer_compare()
	FeedbackManager.show_feedback("现场备注已保存。目标更新。")
	UIManager.close_popup(self)


func _on_close_button_pressed() -> void:
	request_close()


func _finish_layer_compare() -> void:
	GameState.set_flag("layer_compare_done", true)
	GameState.set_flag("report_terminal_unlocked", true)
	GameState.set_flag("current_objective", "前往二号门，核对设施侧数据。")
