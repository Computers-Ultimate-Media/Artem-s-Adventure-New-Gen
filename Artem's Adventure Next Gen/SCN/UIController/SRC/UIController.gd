extends Node

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("debug_kill"):
			get_tree().quit()
