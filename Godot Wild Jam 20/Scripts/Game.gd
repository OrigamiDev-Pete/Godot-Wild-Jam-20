extends Node

var time_start: int
var time_now: int


func _ready() -> void:
	time_start = OS.get_ticks_msec()

func _physics_process(_delta: float) -> void:
	time_now = OS.get_ticks_msec()
	var elapsedmsecs := time_now - time_start
# warning-ignore:integer_division
	var elapsedsecs := elapsedmsecs/1000
# warning-ignore:integer_division
	var minutes := elapsedsecs / 60
	var seconds := elapsedsecs % 60
# warning-ignore:integer_division
	var milliseconds = elapsedmsecs % 1000 / 10
	var time = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	
	$UI/CanvasLayer/Timer.text = time
