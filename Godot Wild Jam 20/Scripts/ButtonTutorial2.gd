extends Control

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		$W.scale = Vector2(2.5, 2.5)
		$Up.scale = Vector2(2.5, 2.5)
	else: 
		$W.scale = Vector2(2, 2)
		$Up.scale = Vector2(2, 2)
	if Input.is_action_pressed("ui_select"):
		$Space.scale = Vector2(2.2, 2.2)
	else: 
		$Space.scale = Vector2(2, 2)
