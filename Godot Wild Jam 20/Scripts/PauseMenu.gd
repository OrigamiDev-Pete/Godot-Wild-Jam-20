extends Control


var level1_time : String setget set_level1_time
var level2_time : String
var level3_time : String

onready var Level1 := $CenterContainer/VBoxContainer/Level1 as HBoxContainer
onready var Level1Medal := $CenterContainer/VBoxContainer/Level1/Control/Medal as AnimatedSprite
onready var Level2 := $CenterContainer/VBoxContainer/Level2 as HBoxContainer
onready var Level2Medal := $CenterContainer/VBoxContainer/Level2/Control/Medal as AnimatedSprite
onready var Level3 := $CenterContainer/VBoxContainer/Level3 as HBoxContainer
onready var Level3Medal := $CenterContainer/VBoxContainer/Level3/Control/Medal as AnimatedSprite


func set_level1_time(value):
	level1_time = value
	$CenterContainer/VBoxContainer/Level1/Time.text = level1_time


func _on_Restart_pressed() -> void:
	pass # Replace with function body.


func _on_Continue_pressed() -> void:
	hide()
	get_tree().paused = false
