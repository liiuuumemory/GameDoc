extends Node

var open_ui_stack: Array = []


func _ready() -> void:
	set_process_unhandled_input(true)
	_update_ui_flag()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and close_top_popup():
		var vp := get_viewport()
		if vp:
			vp.set_input_as_handled()


func register_popup(ui_node: Node) -> void:
	if not is_instance_valid(ui_node):
		return

	_remove_invalid_popups()
	if open_ui_stack.has(ui_node):
		_update_ui_flag()
		return

	open_ui_stack.append(ui_node)
	ui_node.tree_exiting.connect(Callable(self, "_on_popup_tree_exiting").bind(ui_node))
	_update_ui_flag()


func close_top_popup() -> bool:
	_remove_invalid_popups()
	if open_ui_stack.is_empty():
		return false

	var ui_node = open_ui_stack[open_ui_stack.size() - 1]
	if not is_instance_valid(ui_node):
		_remove_invalid_popups()
		_update_ui_flag()
		return false

	if ui_node.has_method("request_close"):
		ui_node.request_close()
	else:
		close_popup(ui_node)

	return true


func close_popup(ui_node: Node) -> void:
	_forget_popup(ui_node)
	_update_ui_flag()

	if not is_instance_valid(ui_node):
		return
	if ui_node.is_queued_for_deletion():
		return
	if ui_node.is_inside_tree():
		ui_node.queue_free()


func has_open_popup() -> bool:
	_remove_invalid_popups()
	return not open_ui_stack.is_empty()


func _on_popup_tree_exiting(ui_node: Node) -> void:
	_forget_popup(ui_node)
	_update_ui_flag()


func _forget_popup(ui_node: Node) -> void:
	while open_ui_stack.has(ui_node):
		open_ui_stack.erase(ui_node)


func _remove_invalid_popups() -> void:
	for index in range(open_ui_stack.size() - 1, -1, -1):
		if not is_instance_valid(open_ui_stack[index]):
			open_ui_stack.remove_at(index)
	_update_ui_flag()


func _update_ui_flag() -> void:
	GameState.set_flag("ui_open", not open_ui_stack.is_empty())
