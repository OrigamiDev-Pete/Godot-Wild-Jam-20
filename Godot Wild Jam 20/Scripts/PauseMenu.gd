extends Control


var paused := false
var paused_time : int
var paused_time_start : int

var level1_time : String setget set_level1_time
var level2_time : String setget set_level2_time
var level3_time : String setget set_level3_time

onready var Level1 := $CenterContainer/VBoxContainer/Level1 as HBoxContainer
onready var Level1Medal := $CenterContainer/VBoxContainer/Level1/Control/Medal as AnimatedSprite
onready var Level2 := $CenterContainer/VBoxContainer/Level2 as HBoxContainer
onready var Level2Medal := $CenterContainer/VBoxContainer/Level2/Control/Medal as AnimatedSprite
onready var Level3 := $CenterContainer/VBoxContainer/Level3 as HBoxContainer
onready var Level3Medal := $CenterContainer/VBoxContainer/Level3/Control/Medal as AnimatedSprite


func _process(_delta: float) -> void:
	if paused:
		paused_time = OS.get_ticks_msec() - paused_time_start


func set_level1_time(value):
	level1_time = value
	$CenterContainer/VBoxContainer/Level1/Time.text = level1_time


func set_level2_time(value):
	level2_time = value
	$CenterContainer/VBoxContainer/Level2/Time.text = level2_time


func set_level3_time(value):
	level3_time = value
	$CenterContainer/VBoxContainer/Level3/Time.text = level3_time


func _on_Restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	


func _on_Continue_pressed() -> void:
	hide()
	get_tree().paused = false
	paused = false
