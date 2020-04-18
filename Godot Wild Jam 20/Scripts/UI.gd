extends Control

signal stage_ended

const Gold: StreamTexture = preload("res://Sprites/Pallets/PalletGold.png")
const Silver: StreamTexture = preload("res://Sprites/Pallets/PalletSilver.png")
const Bronze: StreamTexture = preload("res://Sprites/Pallets/PalletBronze.png")

const LEVEL1_TIMES := [25, 27]
const LEVEL2_TIMES := [38, 43]
const LEVELS := [LEVEL1_TIMES, LEVEL2_TIMES]


var time_start := OS.get_ticks_msec()
var time_now : int
var time : String

var current_level: int = 1
var last_palette: StreamTexture

onready var TimeDisplay := $CanvasLayer/Control/Timer as Label
onready var Medal := $CanvasLayer/Control/Medal as AnimatedSprite
onready var PauseMenu := $CanvasLayer/PauseMenu as Control
onready var Anim := $CanvasLayer/Control/ScoreDisplay/AnimationPlayer as AnimationPlayer

func _ready() -> void:
	connect("stage_ended", get_parent(), "_on_stage_ended")


func _process(_delta: float) -> void:
	TimeDisplay.text = timer()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		PauseMenu.show()
		get_tree().paused = true

func timer() -> String:
	time_now = OS.get_ticks_msec()
	var elapsedmsecs := time_now - time_start
# warning-ignore:integer_division
	var elapsedsecs := elapsedmsecs/1000
# warning-ignore:integer_division
	var minutes := elapsedsecs / 60
	var seconds := elapsedsecs % 60
# warning-ignore:integer_division
	var milliseconds = elapsedmsecs % 1000 / 10
	time = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	check_time(seconds)
	return time


func check_time(current_time: int) -> void:

	if current_time < LEVELS[current_level-1][0]:
		change_medal(Gold)
	elif current_time < LEVELS[current_level-1][1]:
		change_medal(Silver)
	elif current_time > LEVELS[current_level-1][1]:
		change_medal(Bronze)



func change_medal(palette: StreamTexture) -> void:
	if palette != last_palette:
		Medal.get_node("AnimationPlayer").play("Spin")
		Medal.material.set_shader_param("palette", palette)
		last_palette = palette


func _on_stage_ended(_area: Area2D):
	emit_signal("stage_ended", time, current_level)
	$CanvasLayer/Control/ScoreDisplay/Timer2.text = time
	$CanvasLayer/Control/ScoreDisplay/Medal2.material.set_shader_param("palette", Medal.material.get_shader_param("palette"))
	Anim.play("ScoreDisplay")
	current_level += 1
	time_start = OS.get_ticks_msec()
