extends Area2D

var start_rotate = false
var start_rotation = 0
var clockwise: bool
	
func _rotate(value: bool):
	start_rotate = true
	start_rotation = self.rotation_degrees
	clockwise = value;
	
func _process(delta):
	if start_rotate:
		self.rotation_degrees += 20 * delta if clockwise else -20 * delta
		if (self.rotation_degrees >= 90 and clockwise) or (self.rotation_degrees <= 0 and not clockwise):
			start_rotate = false
			self.rotation_degrees = 90 if clockwise else 0

func _on_body_entered(body):
	body.set_collision_layer_value(8, false)
	body.set_collision_mask_value(8, false)
	pass # Replace with function body.
	



func _on_body_exited(body):
	body.set_collision_layer_value(8, !body.character.flying)
	body.set_collision_mask_value(8, !body.character.flying)
	pass # Replace with function body.
