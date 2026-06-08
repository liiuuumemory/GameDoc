extends "res://scripts/interactables/Interactable.gd"

const DATA_LOADER := preload("res://scripts/data/DataLoader.gd")

@export_file("*.json") var data_path := "res://data/scans/facility_data.json"


func interact(_interactor: Node = null) -> void:
	var data := DATA_LOADER.load_json(data_path)
	if data.is_empty():
		push_warning("%s could not load facility data." % name)
		data = _fallback_data()

	GameState.set_flag("facility_data_checked", true)
	GameState.set_flag("facility_data_partial", true)
	GameState.set_flag("current_objective", "返回测绘办公室，提交第一章报告。")
	FeedbackManager.show_feedback("设施侧数据已导入。目标更新。")

	var result_text := str(data.get("base_text", _fallback_data().get("base_text", "")))
	if GameState.get_flag("old_pipe_measured"):
		result_text += "\n\n" + str(data.get("pipe_extra_text", "地面管线读数与设施登记值不一致。建议补充复核。"))

	DialogueManager.show_message(str(data.get("speaker", "设施终端")), result_text)


func _fallback_data() -> Dictionary:
	return {
		"speaker": "设施终端",
		"base_text": "设施侧数据：已导入\n\n市场街表层变化：可部分解释\n旧街区室内读数：解释不足\n低功率管线读数：高于登记值\n建议：作为补充材料保存，不直接作为状态结论",
		"pipe_extra_text": "地面管线读数与设施登记值不一致。建议补充复核。"
	}
