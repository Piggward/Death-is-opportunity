class_name PlayerAnimation
extends AnimatedSprite2D

@onready var character_body_2d = $".."
@export var playable


func _process(delta):
	var velo = character_body_2d.velocity
	if (velo.y < 0):
		if (velo.x > 0):
			self.play("walk_up_right")
		else:
			self.play("walk_up_left")
	elif (velo == Vector2.ZERO):
		self.play("default")
	else:
		if (velo.x < 0):
			self.play("walk_down_left")
		else:
			self.play("walk_down_right")
