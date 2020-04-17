extends Control

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		$D.scale = Vector2(2.5, 2.5)
		$Right.scale = Vector2(2.5, 2.5)
	else: 
		$D.scale = Vector2(2, 2)
		$Right.scale = Vector2(2, 2)
	if Input.is_action_pressed("ui_left"):
		$A.scale = Vector2(2.5, 2.5)
		$Left.scale = Vector2(2.5, 2.5)
	else: 
		$A.scale = Vector2(2, 2)
		$Left.scale = Vector2(2, 2)
