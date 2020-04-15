extends Camera2D

onready var tween: Tween = $Tween as Tween

func move_to_new_player():
#	tween.interpolate_property(self, "global_position", global_position, get_parent().position, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
#	tween.start()
	tween.interpolate_property(self, "position", null, Vector2(0,0), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_property(self, "smoothing_speed", 0, 5, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func camera_lock():
	tween.interpolate_property(self, "smoothing_speed", smoothing_speed, 100, 3, Tween.TRANS_LINEAR)
	tween.start()


func _on_Tween_tween_step(object: Object, key: NodePath, elapsed: float, value: Object) -> void:
	pass


func _on_Camlock_body_entered(body: Node) -> void:
	camera_lock()
