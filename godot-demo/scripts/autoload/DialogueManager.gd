extends Node

const DIALOGUE_BOX_SCENE := preload("res://scenes/ui/DialogueBox.tscn")
const DATA_LOADER := preload("res://scripts/data/DataLoader.gd")

var dialogue_data: Dictionary = {}
var current_node_id := ""
var dialogue_box


func start_dialogue(dialogue_path: String, start_node: String = "start") -> void:
	dialogue_data = DATA_LOADER.load_json(dialogue_path)
	if dialogue_data.is_empty():
		show_message("System", "Dialogue file could not be loaded.")
		return

	current_node_id = start_node
	_show_current_node()


func show_message(speaker: String, text: String) -> void:
	dialogue_data = {
		"start": {
			"speaker": speaker,
			"text": text,
			"options": [
				{"text": "继续", "next": null}
			]
		}
	}
	current_node_id = "start"
	_show_current_node()


func _show_current_node() -> void:
	if not dialogue_data.has(current_node_id):
		close_dialogue()
		return

	var node: Dictionary = dialogue_data[current_node_id]
	var options := _visible_options(node.get("options", []))
	_ensure_dialogue_box()
	if not is_instance_valid(dialogue_box):
		push_warning("Dialogue UI could not be created.")
		return

	dialogue_box.show_node(
		node.get("speaker", ""),
		node.get("text", ""),
		options
	)


func _ensure_dialogue_box() -> void:
	if is_instance_valid(dialogue_box):
		return

	dialogue_box = DIALOGUE_BOX_SCENE.instantiate()
	var tree := get_tree()
	if not tree or not tree.root:
		push_warning("DialogueManager could not access the scene root.")
		dialogue_box = null
		return

	tree.root.add_child(dialogue_box)
	dialogue_box.option_selected.connect(_on_option_selected)
	dialogue_box.close_requested.connect(close_dialogue)
	UIManager.register_popup(dialogue_box)


func _visible_options(options: Array) -> Array:
	var visible := []
	for option in options:
		if typeof(option) != TYPE_DICTIONARY:
			continue
		if _conditions_match(option.get("if", {})):
			visible.append(option)
	return visible


func _conditions_match(conditions) -> bool:
	if typeof(conditions) != TYPE_DICTIONARY:
		return true

	for key in conditions.keys():
		if GameState.get_flag(str(key)) != conditions[key]:
			return false
	return true


func _on_option_selected(option: Dictionary) -> void:
	_apply_sets(option.get("set", {}))

	var next_node = option.get("next", null)
	if next_node == null or str(next_node).is_empty():
		close_dialogue()
		return

	current_node_id = str(next_node)
	_show_current_node()


func _apply_sets(changes) -> void:
	if typeof(changes) != TYPE_DICTIONARY:
		return

	for key in changes.keys():
		GameState.set_flag(str(key), changes[key])


func close_dialogue() -> void:
	if is_instance_valid(dialogue_box):
		UIManager.close_popup(dialogue_box)
	dialogue_box = null
	dialogue_data = {}
	current_node_id = ""
