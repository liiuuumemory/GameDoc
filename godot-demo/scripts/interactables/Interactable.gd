class_name Interactable
extends Area2D

@export var prompt_text := "Interact"


func get_prompt() -> String:
	return prompt_text


func interact(_interactor: Node = null) -> void:
	pass
