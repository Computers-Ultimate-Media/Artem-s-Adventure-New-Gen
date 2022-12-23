extends RigidBody2D

var bullet_speed = 2000
var life_time = 1


func _ready():
	apply_impulse(Vector2(),Vector2(bullet_speed, 0).rotated(rotation))
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()
