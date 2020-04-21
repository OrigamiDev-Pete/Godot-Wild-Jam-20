extends Node



func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	$Stage/Camera2D.queue_free()
	$Stage/AnimationPlayer.queue_free()
