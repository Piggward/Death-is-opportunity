extends CharacterBody2D

@export var run_speed: float

func _physics_process(delta):
	
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	if x_direction:
		velocity.x = x_direction * run_speed
	else:
		velocity.x = move_toward(velocity.x, 0, run_speed)
	if y_direction:
		velocity.y = y_direction * run_speed
	else:
		velocity.y = move_toward(velocity.y, 0, run_speed)

	move_and_slide()
