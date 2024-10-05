extends CharacterBody2D

@export var speed = 60.0

func _physics_process(delta: float) -> void:
	
	var direction = global_position.direction_to(Global.player.global_position)
	
	if direction:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
