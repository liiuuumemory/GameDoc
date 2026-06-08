extends "res://scripts/interactables/Interactable.gd"

@export var beacon_id := 1


func interact(_interactor: Node = null) -> void:
	match beacon_id:
		1:
			_place_beacon_1()
		2:
			_place_beacon_2()
		3:
			_recover_beacon_3()
		_:
			push_warning("Unsupported beacon id: %s" % beacon_id)
			DialogueManager.show_message("信标点", "该信标点尚未启用。")


func _place_beacon_1() -> void:
	if GameState.get_flag("beacon_1_placed"):
		DialogueManager.show_message("信标点 1", "信标 1 已连接。")
		return

	if not GameState.get_flag("tools_received"):
		DialogueManager.show_message("信标点 1", "需要先领取测绘仪和信标。")
		return

	GameState.set_flag("beacon_1_placed", true)
	GameState.add_value("ground_layer_points", 1)
	GameState.add_value("beacons_available", -1)
	GameState.set_flag("current_objective", "布设第二个信标")
	FeedbackManager.show_feedback("滴。信标 1 已连接。目标更新。")
	DialogueManager.show_message("信标点 1", "第一枚信标固定好了。街面读数开始稳定。")


func _place_beacon_2() -> void:
	if not GameState.get_flag("tools_received"):
		DialogueManager.show_message("信标点 2", "需要先领取测绘仪和信标。")
		return

	if not GameState.get_flag("beacon_1_placed"):
		DialogueManager.show_message("信标点 2", "请先完成信标 1。")
		return

	if GameState.get_flag("beacon_2_placed"):
		DialogueManager.show_message("信标点 2", "信标 2 已连接。")
		return

	GameState.set_flag("beacon_2_placed", true)
	GameState.add_value("ground_layer_points", 1)
	GameState.add_value("beacons_available", -1)
	GameState.set_flag("beacon_3_stolen", true)
	GameState.set_flag("current_objective", "进入旧街区")
	FeedbackManager.show_feedback("滴。信标 2 已连接。第三信标偏移。")
	DialogueManager.show_message("测绘仪", "第三信标离开原路线。弱信号在旧状态线外侧。")


func _recover_beacon_3() -> void:
	if not GameState.get_flag("beacon_3_stolen"):
		DialogueManager.show_message("信标 3", "尚未检测到信标偏移。")
		return

	if GameState.get_flag("beacon_3_recovered"):
		DialogueManager.show_message("信标 3", "信标 3 已回收并重新连接。")
		return

	GameState.set_flag("beacon_3_recovered", true)
	GameState.add_value("ground_layer_points", 1)
	GameState.set_flag("current_objective", "读取现场温度")
	FeedbackManager.show_feedback("滴。第三信标重新连接。")
	DialogueManager.show_message("信标 3", "信标接回来了。测绘仪提示附近有温度读数点。")
