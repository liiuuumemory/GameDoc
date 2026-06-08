extends Control


func _on_new_game_pressed() -> void:
	GameState.reset()
	SceneRouter.go_to_scene("res://scenes/levels/SurveyOffice.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
