extends "res://scripts/interactables/Interactable.gd"

@export var scan_id := ""
@export var scan_type := ""
@export var display_name := "扫描点"
@export_multiline var pre_scan_text := ""
@export_multiline var result_text := ""
@export_multiline var feedback_text := ""
@export var sets_flag := ""
@export var adds_value := "old_blocks_scan_count"
@export var add_amount := 1
@export var required_flag := ""
@export_multiline var blocked_text := "先完成前一个现场读数。"
@export var next_objective := ""

var has_previewed := false


func interact(_interactor: Node = null) -> void:
	if scan_id.is_empty():
		push_warning("%s has no scan_id." % name)

	if not required_flag.is_empty() and not GameState.get_flag(required_flag):
		DialogueManager.show_message(display_name, blocked_text)
		return

	if not sets_flag.is_empty() and GameState.get_flag(sets_flag):
		DialogueManager.show_message(display_name, result_text)
		return

	if not has_previewed and not pre_scan_text.is_empty():
		has_previewed = true
		DialogueManager.show_message(display_name, "%s\n\n再次交互开始扫描。" % pre_scan_text)
		return

	if not sets_flag.is_empty():
		GameState.set_flag(sets_flag, true)
	else:
		push_warning("%s has no sets_flag." % name)

	if not adds_value.is_empty():
		GameState.add_value(adds_value, add_amount)
	else:
		push_warning("%s has no adds_value target." % name)

	if not next_objective.is_empty():
		GameState.set_flag("current_objective", next_objective)

	if not feedback_text.is_empty():
		FeedbackManager.show_feedback(feedback_text)
	else:
		FeedbackManager.show_feedback("扫描完成。")

	if int(GameState.get_flag("old_blocks_scan_count")) >= 2 and not GameState.get_flag("field_note_saved"):
		GameState.set_flag("current_objective", "生成图层对比")
		FeedbackManager.show_feedback("图层对比已解锁。")

	DialogueManager.show_message(display_name, result_text)
