extends Control


onready var Menu : Control = $Menu as Control
onready var Credits : Control = $Credits as Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Credts_pressed():
	Menu.hide()
	Credits.show()


func _on_Back_pressed():
	Credits.hide()
	Menu.show()
