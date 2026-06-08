extends "res://scripts/interactables/Interactable.gd"

const REPORT_UI_SCENE := preload("res://scenes/ui/ReportTerminalUI.tscn")


func interact(_interactor: Node = null) -> void:
	if not GameState.get_flag("layer_compare_done"):
		DialogueManager.show_message("报告终端", "现场材料不足。请完成旧街区图层对比。")
		return

	var tree := get_tree()
	if not tree or not tree.root:
		push_warning("ReportTerminal could not access scene root.")
		return

	var existing := tree.root.get_node_or_null("ReportTerminalUI")
	if existing:
		return

	var ui := REPORT_UI_SCENE.instantiate()
	ui.name = "ReportTerminalUI"
	tree.root.add_child(ui)
