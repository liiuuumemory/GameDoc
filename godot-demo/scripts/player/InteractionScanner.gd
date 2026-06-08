extends Area2D

const PROMPT_SCENE := preload("res://scenes/ui/InteractionPrompt.tscn")

var nearby: Array[Node] = []
var prompt


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

	prompt = PROMPT_SCENE.instantiate()
	add_child(prompt)
	prompt.hide_prompt()


func _unhandled_input(event: InputEvent) -> void:
	if GameState.get_flag("ui_open"):
		return

	if event.is_action_pressed("interact"):
		var target := _current_target()
		if target and target.has_method("interact"):
			target.interact(owner)
			_mark_input_as_handled()


func _process(_delta: float) -> void:
	if GameState.get_flag("ui_open"):
		prompt.hide_prompt()
		return

	var target := _current_target()
	if target and target.has_method("get_prompt"):
		prompt.show_prompt(target.get_prompt())
	else:
		prompt.hide_prompt()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("interact"):
		nearby.append(area)


func _on_area_exited(area: Area2D) -> void:
	nearby.erase(area)


func _current_target() -> Node:
	while not nearby.is_empty() and not is_instance_valid(nearby[0]):
		nearby.pop_front()

	if nearby.is_empty():
		return null

	return nearby[0]


func _mark_input_as_handled() -> void:
	var vp := get_viewport()
	if vp:
		vp.set_input_as_handled()
