extends Control

func _ready():
	print("ass")
	pass


func _on_Start_pressed():
	get_tree().change_scene("res://LVL/DEMO Scene/Demo_Scene.tscn")
	


func _on_Quit_pressed():
	get_tree().quit()
