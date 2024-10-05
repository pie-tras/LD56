extends Sprite2D

var theta = 0

func _process(delta: float) -> void:
	theta += delta * 2
	if theta > 2 * PI:
		theta -= 2 * PI
			
	position.y += 0.1 * sin(theta)
