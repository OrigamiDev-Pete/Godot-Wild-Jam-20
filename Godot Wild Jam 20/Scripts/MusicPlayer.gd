extends Node

enum {
	FADE_OUT,
	FADE_IN
}


onready var Layer1 := $Layer1 as AudioStreamPlayer
onready var Layer2 := $Layer2 as AudioStreamPlayer
onready var Intro := $Intro as AudioStreamPlayer
onready var MainTheme := $MainTheme as AudioStreamPlayer

onready var tween := $Tween as Tween


func _ready() -> void:
	pass


func fade_track(layer: AudioStreamPlayer, fade: int = 0, target_db: float = 0.0, speed: float = 1) -> void:
	if fade == FADE_OUT:
		tween.interpolate_property(layer, "volume_db", null, -80 , speed)
		tween.start()
	if fade == FADE_IN:
		tween.interpolate_property(layer, "volume_db", -80, target_db, speed, Tween.TRANS_LINEAR)
		tween.start()


func _on_Start_pressed() -> void:
	fade_track(Layer2, FADE_IN, 0.0, 1)


func start_music() -> void:
	fade_track(Layer1, FADE_OUT, -80, 1)
	fade_track(Layer2, FADE_OUT, -80, 1)
	Intro.play()
	fade_track(Intro, FADE_IN, 0, 0.05)
	$Timer.start()



func _on_Timer_timeout() -> void:
#	MainTheme.play()
#	fade_track(MainTheme, FADE_IN, 0, 0.1)
	pass


func _on_Intro_finished() -> void:
#	MainTheme.play()
	pass
