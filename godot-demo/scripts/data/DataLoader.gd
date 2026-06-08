class_name DataLoader
extends RefCounted


static func load_json(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		push_warning("JSON file does not exist: %s" % path)
		return {}

	var text := FileAccess.get_file_as_string(path)
	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		push_warning("JSON file is not an object: %s" % path)
		return {}

	return parsed
