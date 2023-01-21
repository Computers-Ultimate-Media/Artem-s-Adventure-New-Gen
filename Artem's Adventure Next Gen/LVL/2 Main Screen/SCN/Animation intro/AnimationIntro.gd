extends Node2D

var stop: bool = false

func intro():
	$AnimationLogo.play("Roll in")
	yield(get_tree().create_timer(3), "timeout")
	if not stop: $AnimationLogo.play("Fly in")
	yield(get_tree().create_timer(0.5), "timeout")
	if not stop: $AnimationRect.play("Flashbang")
	yield(get_tree().create_timer(0.2), "timeout")
	if not stop: $ColorRectBlack.hide()
	if not stop: $AnimationRect.play("Dispersion")
	yield(get_tree().create_timer(1.5), "timeout")
	if not stop: $AnimationLogo.play("Dispersion")

func pulsation():
	$AnimationLogo.play("Pulsation")

func reset():
	#$AnimationLogo.play("RESET")
	stop = true
	$ColorRectBlack.hide()
	$AnimationRect.play("RESET")
