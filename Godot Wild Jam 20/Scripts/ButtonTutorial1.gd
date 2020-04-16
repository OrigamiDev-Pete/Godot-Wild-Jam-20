extends Control

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		$D.scale = Vector2(2.5, 2.5)
		$Right.scale = Vector2(2.5, 2.5)
	else: 
		$D.scale = Vector2(2, 2)
		$Right.scale = Vector2(2, 2)
