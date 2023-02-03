extends Node

var main_screen_music = load("res://RES/music/Portalhole.mp3")
var intro_music = load("res://RES/music/Saul.mp3")

func play_music(to_stream):
	$Music.stream = to_stream
	$Music.play()
	pass
