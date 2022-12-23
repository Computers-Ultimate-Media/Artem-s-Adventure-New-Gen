extends KinematicBody2D

class_name Player

var velocity : Vector2 = Vector2.ZERO

var ACCELERATION : int = 30
var DECELERATION : int = 50
var MAX_ACCELERATION : int = 700

var CURRENT_ACCELERATION : int = 0
var LAST_DIRECTION : int = 0

var JUMP_FORCE : int = 1000
var GRAVITY : int = 30

var coyote_jump : bool = false
var jump_buffer : bool = false

var wall_jump : bool = true

var chain_velocity := Vector2(0,0)
const CHAIN_PULL = 105

func _ready():
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event.button_index == BUTTON_LEFT):
			if Input.is_action_pressed("hand_activate"):
				# We clicked the mouse -> shoot()
				$Chain.shoot(event.position - get_viewport().size * 0.5)
				pass
			if Input.is_action_just_released("hand_activate"):
				# We released the mouse -> release()
				$Chain.release()
				pass

func _physics_process(delta) -> void:
	var input : Vector2 = Vector2.ZERO
	var walk = (Input.get_action_strength("player_right") - Input.get_action_strength("player_left")) * ACCELERATION
	
	apply_gravity()
	
	input.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	if input.x != 0:
		LAST_DIRECTION = input.x
	
		# Hook physics
	if $Chain.hooked:
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		chain_velocity = to_local($Chain.tip).normalized() * CHAIN_PULL
		if chain_velocity.y > 0:
			# Pulling down isn't as strong
			chain_velocity.y *= 0.55
		else:
			# Pulling up is stronger
			chain_velocity.y *= 1.65
		if sign(chain_velocity.x) != sign(walk):
			# if we are trying to walk in a different
			# direction than the chain is pulling
			# reduce its pull
			chain_velocity.x *= 0.7
	else:
		# Not hooked -> no chain velocity
		chain_velocity = Vector2(0,0)
	velocity += chain_velocity
	
	animation()
	
	if input.x == 0 and is_on_floor():
		apply_friction()
	elif input.x != 0 and not is_on_floor():
		apply_accelration(LAST_DIRECTION)
	elif input.x != 0 and is_on_floor():
		apply_accelration(input.x)
	
	#coyote killed different forced jump
	if is_on_floor() or coyote_jump == true:
		if Input.is_action_just_pressed("player_jump") or jump_buffer == true:
			velocity.y = -JUMP_FORCE
			jump_buffer = false
	else:
		if Input.is_action_just_pressed("player_jump"):
			jump_buffer = true
			$JumpBufferTimer.start()
		
		#!!!!!!!!!
		if Input.is_action_just_pressed("player_jump") and is_on_wall() and wall_jump and ($RightUpCollideCheck.is_colliding() or $LeftUpCollideCheck.is_colliding()):
			velocity.y = -JUMP_FORCE
			wall_jump = false
			
		#linear increase in gravity
		if velocity.y > 0:
			velocity.y += 4
	
	if Input.is_action_just_released("player_jump") and velocity.y < -(JUMP_FORCE/2):
			velocity.y = -(JUMP_FORCE/2)
	
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		coyote_jump = true
		$CoyoteTimer.start()
	
	#Обновляться возможность прыжка может, когда игрок находиться в воздухе / когда игрок упал наземь. Но! Столкновения и проверка на стены не всегда работает!
	if not $RightUpCollideCheck.is_colliding() and not $LeftUpCollideCheck.is_colliding():
		wall_jump = true
	
	#return wall_jump if is in air 
	#if (was_on_wall and not is_on_wall()) or is_on_floor():
	#if not $LeftUpCollideCheck.is_colliding() and not $RightUpCollideCheck.is_colliding():
	#	wall_buffer = true
	
	#print(String(velocity.x) + " | " + String(velocity.y) + " | " + String(LAST_DIRECTION))
	#print(CURRENT_ACCELERATION)
	print(is_on_wall())
	pass


#func apply_accelration(direction):
#	CURRENT_ACCELERATION += ACCELERATION * int(CURRENT_ACCELERATION < MAX_ACCELERATION) + 0 * int(CURRENT_ACCELERATION >= MAX_ACCELERATION)
#	velocity.x = (MAX_ACCELERATION * int(CURRENT_ACCELERATION >= MAX_ACCELERATION) + CURRENT_ACCELERATION * int(CURRENT_ACCELERATION < MAX_ACCELERATION)) * direction

func apply_gravity():
	velocity.y += GRAVITY

func apply_friction():
	CURRENT_ACCELERATION = move_toward(velocity.x, 0, DECELERATION)
	velocity.x = CURRENT_ACCELERATION
	
#func apply_accelration(direction):
#	velocity.x += ACCELERATION * direction
#	velocity.x = (MAX_ACCELERATION * int(abs(velocity.x) >= MAX_ACCELERATION) + velocity.x * int(abs(velocity.x) < MAX_ACCELERATION))

#func apply_friction():
#	velocity.x = move_toward(velocity.x, 0, DECELERATION)

func apply_accelration(direction):
	velocity.x = move_toward(velocity.x, MAX_ACCELERATION * direction, ACCELERATION)
	
func animation():
	if Input.is_action_pressed("player_left"):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("player_right"):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")


func _on_CoyoteTimer_timeout():
	coyote_jump = false


func _on_JumpBufferTimer_timeout():
	jump_buffer = false

func _on_WallJumpTimer_timeout():
	wall_jump = true
