extends Node

var main_screen_music = load("res://RES/music/Portalhole.mp3")
var intro_music = load("res://RES/music/Saul.mp3")

func play_music():
	$Music.stream = intro_music
	$Music.play()
	pass
