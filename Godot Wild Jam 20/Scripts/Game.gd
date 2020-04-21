extends Node

const Level1: PackedScene = preload("res://Scenes/Level1.tscn")
const Level2: PackedScene = preload("res://Scenes/Level2.tscn")
const HUD: PackedScene = preload("res://Scenes/UI.tscn")

var ui: Control
var level1: Node
var level2: Node2D


var tutorial_on := true
var level1_time : String
var level2_time : String


func _on_Start_pressed() -> void:
	if tutorial_on:
		level1 = Level1.instance()
		add_child(level1)
		level1.get_node("Stage/AnimationPlayer").play("Intro")
		var Starter1: Area2D = level1.get_node("Starter") as Area2D
		Starter1.connect("body_entered", self, "_on_Starter1_body_entered")
	else:
		level1 = Level1.instance()

		add_child_below_node($Background, level1)
		level1.get_node("Stage/Player").position.x = 3570
		level1.get_node("Stage/Camera2D").position = Vector2(3570, 58)
		level1.get_node("Stage/AnimationPlayer").play("IntroSkip")
		
		var Starter1: Area2D = level1.get_node("Starter") as Area2D
		Starter1.connect("body_entered", self, "_on_Starter1_body_entered")

	$MainMenu.queue_free()


func _on_Starter1_body_entered(_body: Node):
#	get_node("UI/CanvasLayer/Control").visible = true
	ui = HUD.instance()
	add_child(ui)
	level2 = $Level2
	var StageEnd := level2.get_node("Stage/Player/Area2D") as Area2D
	StageEnd.connect("area_entered", ui, "_on_stage_ended")
	$MusicPlayer.start_music()


func _on_stage_ended(time: String, level: int):
	match level:
		1:
			level1_time = time
		2:
			level2_time = time
		3:
			pass


func _on_Tutorial_toggled(button_pressed: bool) -> void:
	tutorial_on = button_pressed
