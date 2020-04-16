extends Area2D

func _on_Camlock_body_entered(body: Node) -> void:
	if body.has_method("camera_lock"):
		body.camera_lock()
		queue_free()
