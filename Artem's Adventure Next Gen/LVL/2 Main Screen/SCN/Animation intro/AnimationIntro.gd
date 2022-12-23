extends Node2D

func intro():
	$AnimationLogo.play("Roll in")
	yield(get_tree().create_timer(3), "timeout")
	$AnimationLogo.play("Fly in")
	yield(get_tree().create_timer(0.5), "timeout")
	$AnimationRect.play("Flashbang")
	yield(get_tree().create_timer(0.2), "timeout")
	$ColorRectBlack.hide()
	$AnimationRect.play("Dispersion")
	yield(get_tree().create_timer(1.5), "timeout")
	$AnimationLogo.play("Dispersion")

func pulsation():
	$AnimationLogo.play("Pulsation")

func reset():
	$AnimationLogo.play("RESET")
	$AnimationRect.play("RESET")
