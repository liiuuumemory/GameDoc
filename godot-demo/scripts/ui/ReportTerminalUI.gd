extends CanvasLayer

const DATA_LOADER := preload("res://scripts/data/DataLoader.gd")
const REPORT_DATA_PATH := "res://data/reports/chapter_01_reports.json"
const MAIN_MENU_SCENE := "res://scenes/app/MainMenu.tscn"

@onready var title_label := get_node_or_null("Panel/MarginContainer/VBox/TitleLabel") as Label
@onready var summary_label := get_node_or_null("Panel/MarginContainer/VBox/SummaryLabel") as Label
@onready var options_box := get_node_or_null("Panel/MarginContainer/VBox/ContentRow/OptionsBox") as VBoxContainer
@onready var detail_label := get_node_or_null("Panel/MarginContainer/VBox/ContentRow/DetailBox/DetailMargin/DetailLabel") as Label
@onready var submit_button := get_node_or_null("Panel/MarginContainer/VBox/ButtonRow/SubmitButton") as Button
@onready var back_button := get_node_or_null("Panel/MarginContainer/VBox/ButtonRow/BackButton") as Button
@onready var close_button := get_node_or_null("Panel/MarginContainer/VBox/ButtonRow/CloseButton") as Button

var report_options: Array = []
var selected_option: Dictionary = {}
var ending_summary := ""
var mode := "select"


func _ready() -> void:
	_load_report_options()
	_wire_buttons()
	if GameState.get_flag("chapter_01_completed"):
		ending_summary = "第一章已完成。报告已提交。"
		_show_ending_summary()
	else:
		_render_report()
	UIManager.register_popup(self)


func request_close() -> void:
	UIManager.close_popup(self)


func _load_report_options() -> void:
	var data := DATA_LOADER.load_json(REPORT_DATA_PATH)
	if data.is_empty():
		push_warning("ReportTerminalUI using fallback report data.")
		data = _fallback_report_data()

	var options = data.get("options", [])
	if typeof(options) == TYPE_ARRAY:
		report_options = options
	else:
		push_warning("Report data has no options array.")
		report_options = _fallback_report_data().get("options", [])


func _wire_buttons() -> void:
	if submit_button:
		submit_button.pressed.connect(_on_submit_pressed)
	else:
		push_warning("ReportTerminalUI is missing SubmitButton.")

	if back_button:
		back_button.pressed.connect(_on_back_pressed)
	else:
		push_warning("ReportTerminalUI is missing BackButton.")

	if close_button:
		close_button.pressed.connect(_on_close_pressed)
	else:
		push_warning("ReportTerminalUI is missing CloseButton.")


func _render_report() -> void:
	mode = "select"
	if title_label:
		title_label.text = "第一章报告终端"
	if summary_label:
		summary_label.text = _collected_summary()
	else:
		push_warning("ReportTerminalUI is missing SummaryLabel.")

	_build_option_buttons()
	selected_option = {}
	if detail_label:
		detail_label.text = "选择一个报告选项查看说明。"
	if submit_button:
		submit_button.visible = true
		submit_button.text = "提交报告"
		submit_button.disabled = true
	if back_button:
		back_button.visible = false
		back_button.text = "返回修改"
	if close_button:
		close_button.visible = true
		close_button.text = "关闭终端"


func _build_option_buttons() -> void:
	if not options_box:
		push_warning("ReportTerminalUI is missing OptionsBox.")
		return

	for child in options_box.get_children():
		child.queue_free()

	for option in report_options:
		if typeof(option) != TYPE_DICTIONARY:
			continue

		var enabled := _condition_matches(option.get("condition", {}))
		var button := Button.new()
		button.text = str(option.get("title", "未命名选项"))
		button.custom_minimum_size = Vector2(0, 26)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.disabled = not enabled
		button.tooltip_text = "" if enabled else str(option.get("missing", "缺少材料。"))
		button.pressed.connect(_on_report_option_pressed.bind(option))
		options_box.add_child(button)


func _on_report_option_pressed(option: Dictionary) -> void:
	selected_option = option

	var detail := str(option.get("description", ""))
	var consequence := str(option.get("ending_summary", ""))
	if not consequence.is_empty():
		detail += "\n\n提交后：%s" % consequence

	if detail_label:
		detail_label.text = detail

	if submit_button:
		submit_button.disabled = false
		submit_button.text = "关闭终端" if selected_option.get("closes", false) else "提交所选报告"


func _on_submit_pressed() -> void:
	if selected_option.is_empty():
		return

	if mode == "confirm":
		_confirm_submit()
		return

	if selected_option.get("closes", false):
		request_close()
		return

	_show_submit_confirm()


func _show_submit_confirm() -> void:
	mode = "confirm"

	if title_label:
		title_label.text = "确认提交报告"
	if summary_label:
		summary_label.text = "确认提交该报告？\n提交后将结束第一章。"

	if options_box:
		for child in options_box.get_children():
			child.queue_free()

	if detail_label:
		detail_label.text = "报告选项：%s\n\n%s" % [
			str(selected_option.get("title", "未命名选项")),
			str(selected_option.get("ending_summary", "报告已提交。"))
		]

	if submit_button:
		submit_button.visible = true
		submit_button.disabled = false
		submit_button.text = "确认提交"
	if back_button:
		back_button.visible = true
		back_button.text = "返回选择"
	if close_button:
		close_button.visible = true
		close_button.text = "关闭终端"


func _confirm_submit() -> void:
	_apply_sets(selected_option.get("sets", {}))
	GameState.set_flag("chapter_01_completed", true)
	FeedbackManager.show_feedback("报告已提交。")
	ending_summary = str(selected_option.get("ending_summary", "报告已提交。"))
	_show_ending_summary()


func _show_ending_summary() -> void:
	mode = "ended"
	if title_label:
		title_label.text = "第一章报告已提交"
	if summary_label:
		summary_label.text = "%s\n\n第一章已完成。报告已提交。" % ending_summary

	if options_box:
		for child in options_box.get_children():
			child.queue_free()

		var main_menu_button := Button.new()
		main_menu_button.text = "返回主菜单"
		main_menu_button.custom_minimum_size = Vector2(0, 28)
		main_menu_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		main_menu_button.pressed.connect(_on_return_to_menu_pressed)
		options_box.add_child(main_menu_button)

		var variables_button := Button.new()
		variables_button.text = "查看变量摘要"
		variables_button.custom_minimum_size = Vector2(0, 28)
		variables_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		variables_button.pressed.connect(_show_variable_summary)
		options_box.add_child(variables_button)

	if detail_label:
		detail_label.text = "关闭摘要会保留在当前场景中，但报告已提交，不能返回修改。"
	if submit_button:
		submit_button.visible = false
	if back_button:
		back_button.visible = false
	if close_button:
		close_button.visible = true
		close_button.text = "关闭摘要"


func _show_variable_summary() -> void:
	if not detail_label:
		push_warning("ReportTerminalUI is missing DetailLabel.")
		return

	detail_label.text = "\n".join([
		"report_choice: %s" % _value_text("report_choice"),
		"old_blocks_scan_count: %s" % _value_text("old_blocks_scan_count"),
		"field_note_saved: %s" % _value_text("field_note_saved"),
		"discrepancy_note_submitted: %s" % _value_text("discrepancy_note_submitted"),
		"residents_reported: %s" % _value_text("residents_reported"),
		"names_withheld: %s" % _value_text("names_withheld"),
		"facility_data_checked: %s" % _value_text("facility_data_checked")
	])


func _on_return_to_menu_pressed() -> void:
	UIManager.close_popup(self)
	SceneRouter.go_to_scene(MAIN_MENU_SCENE)


func _on_back_pressed() -> void:
	if mode == "confirm":
		_render_report()


func _on_close_pressed() -> void:
	request_close()


func _apply_sets(changes) -> void:
	if typeof(changes) != TYPE_DICTIONARY:
		return

	for key in changes.keys():
		GameState.set_flag(str(key), changes[key])


func _condition_matches(condition) -> bool:
	if typeof(condition) != TYPE_DICTIONARY or condition.is_empty():
		return true

	if condition.has("all"):
		var all_conditions = condition.get("all", [])
		if typeof(all_conditions) != TYPE_ARRAY:
			return false
		for entry in all_conditions:
			if not _condition_matches(entry):
				return false
		return true

	if condition.has("any"):
		var any_conditions = condition.get("any", [])
		if typeof(any_conditions) != TYPE_ARRAY:
			return false
		for entry in any_conditions:
			if _condition_matches(entry):
				return true
		return false

	if condition.has("flag"):
		var expected = condition.get("equals", true)
		return GameState.get_flag(str(condition.get("flag", ""))) == expected

	if condition.has("value"):
		var current := _int_flag(str(condition.get("value", "")))
		if condition.has("min"):
			return current >= int(condition.get("min", 0))
		if condition.has("max"):
			return current <= int(condition.get("max", 0))

	return true


func _collected_summary() -> String:
	var lines := [
		"信标 1：%s" % _done_text("beacon_1_placed", "已布设", "未布设"),
		"信标 2：%s" % _done_text("beacon_2_placed", "已布设", "未布设"),
		"信标 3：%s" % _done_text("beacon_3_recovered", "已回收或重新布设", "未完成"),
		"旧街区扫描点：%s/3" % _int_flag("old_blocks_scan_count"),
		"图层对比：%s" % _done_text("layer_compare_done", "已完成", "未完成")
	]

	if GameState.get_flag("indoor_temp_measured"):
		lines.append("室内温度读数：已记录")
	if GameState.get_flag("old_sensor_cache_read"):
		lines.append("旧传感器缓存：已读取")
	if GameState.get_flag("old_pipe_measured"):
		lines.append("低功率管线读数：已记录")

	lines.append("现场备注：%s" % _done_text("field_note_saved", "已保存", "未保存"))
	lines.append("偏差附录草稿：%s" % _done_text("discrepancy_note_drafted", "已创建", "未创建"))
	lines.append("设施侧数据：%s" % _done_text("facility_data_checked", "已核对", "未核对"))

	return "\n".join(lines)


func _done_text(flag_name: String, yes_text: String, no_text: String) -> String:
	return yes_text if GameState.get_flag(flag_name) else no_text


func _value_text(flag_name: String) -> String:
	var value = GameState.get_flag(flag_name)
	return "未记录" if value == null else str(value)


func _int_flag(flag_name: String) -> int:
	var value = GameState.get_flag(flag_name)
	if typeof(value) == TYPE_INT or typeof(value) == TYPE_FLOAT:
		return int(value)
	return 0


func _fallback_report_data() -> Dictionary:
	return {
		"options": [
			{
				"id": "maintain_buffer_status",
				"title": "维持缓冲状态",
				"description": "按现有轨道图层和居住状态推进。旧街区不作为长期居住区处理。",
				"ending_summary": "报告按标准格式提交。旧街区现场材料被保留为备注，状态调整流程继续。",
				"sets": {"report_choice": "maintain_buffer_status"}
			}
		]
	}
