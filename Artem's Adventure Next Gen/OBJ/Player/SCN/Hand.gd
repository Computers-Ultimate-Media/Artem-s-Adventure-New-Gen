extends KinematicBody2D

export (int) var speed = 10

var velocity = Vector2()
var pre_position = position
var hand_vision = 1

var can_move = false
var direction

#bullet
var bullet = preload("res://OBJ/Projectiles/Projectile.tscn")
var can_fire = true
var rate_of_fire = 0.4
#######

func _ready():
	self.hide()
	self.show()
	pre_position = position
	pass
	
func _unhandled_input(event):
	#self.hide()
	#self.show()
	pass

func _process(delta):
	velocity = Vector2()
	ControlLoop()
	pass
	

func _physics_process(delta):
	if (can_move == true):
		Move()
	pass

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if (event.button_index == BUTTON_LEFT):
			if Input.is_action_just_released("hand_activate"):
				can_fire = true
				self.show()
				pass
			if Input.is_action_pressed("hand_activate"):
				self.hide()
				can_fire = false
				pass
			pass
		if (event.button_index == BUTTON_RIGHT):
			if Input.is_action_pressed("hand_shoot") and can_fire == true:
				Fire()
				pass
			pass
		pass
	pass

func ControlLoop():
	if (can_move == false):
		look_at(get_global_mouse_position())
		
#	if Input.is_action_just_pressed("hand_activate"):
#
#		pass
#
#	if Input.is_action_pressed("hand_activate"):
#		self.visible = false
#		can_fire = false
#		pass

#FIRE
	if not Input.is_action_pressed("hand_activate") and Input.is_action_pressed("hand_shoot") and can_fire == true:
		Fire()
		pass
	if Input.is_action_just_released("hand_activate"):
		can_fire = true
		pass
	pass

func Move():
	velocity = Vector2(speed, 0).rotated(rotation)
	position+=velocity
	self.show()
	pass

func HandVision():
	self.show()
	yield(get_tree().create_timer(hand_vision), "timeout")
	self.hide()

func Fire():
	can_fire = false
	#########
	get_node("TurnAxis/BulletPoint").rotation = get_angle_to(get_global_mouse_position())
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_node("TurnAxis/BulletPoint").get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	#########
	yield(get_tree().create_timer(rate_of_fire), "timeout")
	can_fire = true
	pass

func _on_HandLimits_area_entered(area):
	#print("area")
	can_move = false
	position = pre_position
	pass # Replace with function body.


func _on_HandLimits_area_exited(area):
	#can_fire = true
	pass # Replace with function body.
