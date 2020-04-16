extends Node

var time_start: int
var time_now: int


func _ready() -> void:
	time_start = OS.get_system_time_msecs()

func _process(_delta: float) -> void:
	time_now = OS.get_system_time_msecs()
	var elapsedmsecs = time_now - time_start
	var elapsedsecs = elapsedmsecs/1000
	var minutes = elapsedsecs / 60
	var seconds = elapsedsecs % 60
	var milliseconds = elapsedmsecs % 1000
	var time = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	
	$UI/CanvasLayer/Timer.text = time
