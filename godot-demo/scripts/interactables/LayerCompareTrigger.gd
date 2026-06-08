extends "res://scripts/interactables/Interactable.gd"

const LAYER_COMPARE_SCENE := preload("res://scenes/ui/LayerCompareUI.tscn")


func interact(_interactor: Node = null) -> void:
	if int(GameState.get_flag("old_blocks_scan_count")) < 2:
		DialogueManager.show_message("测绘仪", "还缺现场证据。请至少完成两个旧街区扫描点。")
		return

	var tree := get_tree()
	if not tree or not tree.root:
		push_warning("LayerCompareTrigger could not access scene root.")
		return

	var existing := tree.root.get_node_or_null("LayerCompareUI")
	if existing:
		return

	var ui := LAYER_COMPARE_SCENE.instantiate()
	ui.name = "LayerCompareUI"
	tree.root.add_child(ui)
