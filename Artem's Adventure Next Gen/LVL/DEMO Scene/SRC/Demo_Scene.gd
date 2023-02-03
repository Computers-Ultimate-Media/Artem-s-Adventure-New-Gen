extends Node2D

var back_sound = load("res://RES/music/Tilekid_-_you_not_the_same_(musmore.com).mp3")

func _ready():
	
	MusicController.play_music(back_sound)
	
	VisualServer.set_default_clear_color(Color.black)
	GuiController.game_session = true
