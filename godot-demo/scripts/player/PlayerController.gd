extends CharacterBody2D

@export var speed := 160.0


func _physics_process(_delta: float) -> void:
	if GameState.get_flag("ui_open"):
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_vector.normalized() * speed
	move_and_slide()
