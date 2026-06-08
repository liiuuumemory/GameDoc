extends Node

var defaults := {
	"tools_received": false,
	"beacons_available": 0,
	"beacon_1_placed": false,
	"beacon_2_placed": false,
	"beacon_3_stolen": false,
	"beacon_3_recovered": false,
	"mara_intro_done": false,
	"jun_met": false,
	"old_blocks_entered": false,
	"indoor_temp_measured": false,
	"old_sensor_cache_read": false,
	"old_pipe_measured": false,
	"old_blocks_scan_count": 0,
	"field_note_saved": false,
	"discrepancy_note_drafted": false,
	"layer_compare_done": false,
	"facility_data_checked": false,
	"facility_data_partial": false,
	"report_terminal_unlocked": false,
	"residents_reported": false,
	"discrepancy_note_submitted": false,
	"names_withheld": false,
	"chapter_01_completed": false,
	"ui_open": false,
	"ground_layer_points": 0,
	"current_objective": "领取测绘工具",
	"current_scene_id": "main_menu",
	"report_choice": ""
}

var values := {}


func _ready() -> void:
	reset()


func set_flag(name: String, value) -> void:
	values[name] = value


func get_flag(name: String):
	return values.get(name, defaults.get(name, null))


func add_value(name: String, amount: int) -> void:
	var raw_value = values.get(name, defaults.get(name, 0))
	var current := 0
	if typeof(raw_value) == TYPE_INT or typeof(raw_value) == TYPE_FLOAT:
		current = int(raw_value)
	values[name] = current + amount


func reset() -> void:
	values = defaults.duplicate(true)
