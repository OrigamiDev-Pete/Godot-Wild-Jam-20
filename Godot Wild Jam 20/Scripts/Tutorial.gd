extends Control

onready var Pop : AudioStreamPlayer = $Pop as AudioStreamPlayer


func _on_TutorialStep1_body_entered(_body: Node) -> void:
	$CanvasLayer/ButtonTutorial1.hide()


func _on_TutorialStep2_body_entered(_body: Node) -> void:
	$CanvasLayer/ButtonTutorial2.show()
	pass


func _on_TutorialStep2_body_exited(_body: Node) -> void:
	$CanvasLayer/ButtonTutorial2.hide()


func _on_ButtonTutorial2_visibility_changed() -> void:
	if $CanvasLayer/ButtonTutorial2.visible:
		Pop.pitch_scale = 2
		Pop.play(0.01)
	else:
		Pop.pitch_scale = 2.5
		Pop.play()


func _on_ButtonTutorial1_visibility_changed() -> void:
	if !$CanvasLayer/ButtonTutorial1.visible:
		Pop.pitch_scale = 2.5
		Pop.play()
