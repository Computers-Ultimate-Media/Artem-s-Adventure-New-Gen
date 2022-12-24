extends Control

var game_session : bool = false
var pause_screen : bool = false

func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_cancel") and game_session == true and pause_screen == false:
			print("show")
			yield(get_tree().create_timer(0.2), "timeout")
			$PauseScreen.show()
			pause_screen = true
		if Input.is_action_just_pressed("ui_cancel") and game_session == true and pause_screen == true:
			print("hide")
			yield(get_tree().create_timer(0.2), "timeout")
			$PauseScreen.hide()
			pause_screen = false
