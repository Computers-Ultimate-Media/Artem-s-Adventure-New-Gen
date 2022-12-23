extends ParallaxLayer

export(float) var X_SPEED = -100
export(float) var Y_SPEED = -100

func _process(delta) -> void:
	self.motion_offset.x += X_SPEED * delta
	self.motion_offset.y += Y_SPEED * delta
