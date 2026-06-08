extends "res://scripts/interactables/Interactable.gd"

enum Mode {
	DIALOGUE,
	GIVE_TOOLS,
	DOOR
}

@export var mode: Mode = Mode.DIALOGUE
@export_file("*.json") var dialogue_path := ""
@export_file("*.tscn") var target_scene := ""
@export var required_flag := ""
@export var set_flag_on_use := ""
@export var set_value_on_use := true
@export var objective_on_use := ""
@export var feedback_on_use := ""
@export_multiline var blocked_text := "当前无法进入。"


func interact(_interactor: Node = null) -> void:
	match mode:
		Mode.DIALOGUE:
			_apply_use_flag()
			if dialogue_path.is_empty():
				push_warning("%s has no dialogue file." % name)
				DialogueManager.show_message(prompt_text, "没有可读取的信息。")
			else:
				DialogueManager.start_dialogue(dialogue_path)
		Mode.GIVE_TOOLS:
			_receive_tools()
		Mode.DOOR:
			_try_door()


func _receive_tools() -> void:
	_apply_use_flag()
	GameState.set_flag("tools_received", true)
	GameState.set_flag("beacons_available", 3)
	GameState.set_flag("current_objective", "在市场街布设第一个信标")
	FeedbackManager.show_feedback("工具已领取。目标更新。")
	DialogueManager.show_message("信标箱", "测绘仪和三枚信标已领。先去市场街。")


func _try_door() -> void:
	if target_scene.is_empty():
		push_warning("%s has no target_scene." % name)
		DialogueManager.show_message("出口", "目标场景未设置。")
		return

	if not required_flag.is_empty() and not GameState.get_flag(required_flag):
		DialogueManager.show_message("出口", blocked_text)
		return

	_apply_use_flag()
	_apply_objective_feedback()
	SceneRouter.go_to_scene(target_scene)


func _apply_use_flag() -> void:
	if not set_flag_on_use.is_empty():
		GameState.set_flag(set_flag_on_use, set_value_on_use)


func _apply_objective_feedback() -> void:
	if not objective_on_use.is_empty():
		GameState.set_flag("current_objective", objective_on_use)
	if not feedback_on_use.is_empty():
		FeedbackManager.show_feedback(feedback_on_use)
