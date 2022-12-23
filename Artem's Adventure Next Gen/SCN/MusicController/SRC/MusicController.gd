extends Node

var main_screen_music = load("res://RES/music/Portalhole.mp3")

func play_music():
	$Music.stream = main_screen_music
	$Music.play()
