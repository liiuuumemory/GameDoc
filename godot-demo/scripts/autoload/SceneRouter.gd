extends Node


func go_to_scene(scene_path: String, spawn_id: String = "") -> void:
	if scene_path.is_empty():
		push_warning("SceneRouter.go_to_scene called with an empty path.")
		return
	if not ResourceLoader.exists(scene_path):
		push_warning("Scene does not exist: %s" % scene_path)
		return

	GameState.set_flag("current_scene_id", scene_path.get_file().get_basename())
	var tree := get_tree()
	if not tree:
		push_warning("SceneRouter could not access SceneTree.")
		return

	var error := tree.change_scene_to_file(scene_path)
	if error != OK:
		push_error("Could not change scene to %s. Error: %s" % [scene_path, error])
