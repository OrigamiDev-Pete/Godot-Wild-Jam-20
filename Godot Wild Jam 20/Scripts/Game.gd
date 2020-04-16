extends Node

var time_start: int
var time_now: int


func _ready() -> void:
	time_start = OS.get_unix_time()

func _process(_delta: float) -> void:
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var time = "%02d:%02d" % [minutes, seconds]
	
	$UI/CanvasLayer/Timer.text = time
