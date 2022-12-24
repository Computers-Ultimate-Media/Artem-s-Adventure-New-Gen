extends Area2D

var rage_shouting = load("res://OBJ/White Frog/SND/Rage Shouting.mp3")

func _ready():
	$AnimationPlayer.play("Idle")

func _on_White_Forg_body_entered(body):
	if (body is projectile):
		$AnimationPlayer.play("Shouting")
		shout()
		yield(get_tree().create_timer(1), "timeout")
		$AnimationPlayer.play("Idle")

func shout():
	$Sounds.stream = rage_shouting
	$Sounds.play()
