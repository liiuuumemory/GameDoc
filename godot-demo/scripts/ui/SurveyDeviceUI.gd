extends CanvasLayer

@onready var objective_label := get_node_or_null("Panel/MarginContainer/VBox/ObjectiveLabel") as Label
@onready var beacon_label := get_node_or_null("Panel/MarginContainer/VBox/BeaconLabel") as Label
@onready var scan_label := get_node_or_null("Panel/MarginContainer/VBox/ScanLabel") as Label
@onready var compare_label := get_node_or_null("Panel/MarginContainer/VBox/CompareLabel") as Label


func _process(_delta: float) -> void:
	_update_text()


func _update_text() -> void:
	var placed := 0
	if GameState.get_flag("beacon_1_placed"):
		placed += 1
	if GameState.get_flag("beacon_2_placed"):
		placed += 1
	if GameState.get_flag("beacon_3_recovered"):
		placed += 1

	var shifted := 0
	if GameState.get_flag("beacon_3_stolen") and not GameState.get_flag("beacon_3_recovered"):
		shifted = 1

	var scan_count := int(GameState.get_flag("old_blocks_scan_count"))
	var can_compare := scan_count >= 2

	if objective_label:
		objective_label.text = "当前目标：%s" % str(GameState.get_flag("current_objective"))
	if beacon_label:
		beacon_label.text = "信标：%s/3 已布设，%s 个信号偏移" % [placed, shifted]
	if scan_label:
		scan_label.text = "旧街区扫描：%s/3" % scan_count
	if compare_label:
		if GameState.get_flag("layer_compare_done"):
			compare_label.text = "图层对比：已完成"
		else:
			compare_label.text = "图层对比：%s" % ("可生成" if can_compare else "未解锁")
