extends Node2D

#TODO: fix the timers!

func _ready():
	MusicController.play_music()
	$Control.hide()
	play_animation()

func play_animation():
#	$AnimationLogo.play("Fade in")
#	yield(get_tree().create_timer(6), "timeout")
#	$AnimationRect.play("Fade in")
#	yield(get_tree().create_timer(3), "timeout")
	$AnimatedIntro.intro()

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
#			$AnimationRect.play("RESET")
#			$PressStartMessage.hide()
#			$AnimationLogo.play("Pulsation")
#			$Control.show()
#			yield(get_tree().create_timer(3), "timeout")
			$AnimatedIntro.reset()
			$PressStartMessage.hide()
			$Control.show()
			$AnimatedIntro.pulsation()
