extends Node2D

var sound_intro = load("res://RES/music/die.mp3")

func _ready():
	MusicController.play_music(sound_intro)
	$AnimationPlayer.play("Fade in")
	yield(get_tree().create_timer(3), "timeout")
	$AnimationPlayer.play("Fade out")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://LVL/2 Main Screen/Main_Screen.tscn")
