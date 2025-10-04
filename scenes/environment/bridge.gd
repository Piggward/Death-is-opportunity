extends Area2D

var start_rotate = false
var start_rotation = 0
var clockwise: bool
@onready var moving_collisions = $MovingCollisions
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
const BRIDGE_MOVING = preload("uid://csnnofbp8a38b")
const BRIDGE_STOP = preload("uid://rbfbk4ncnonm")

func _rotate(value: bool):
	start_rotate = true
	audio_stream_player_2d.stream = BRIDGE_MOVING
	audio_stream_player_2d.play()
	for child: CollisionShape2D in moving_collisions.get_children():
		child.disabled = true
	start_rotation = self.rotation_degrees
	clockwise = value;
	
func _process(delta):
	if start_rotate:
		self.rotation_degrees += 20 * delta if clockwise else -20 * delta
		if (self.rotation_degrees >= 90 and clockwise) or (self.rotation_degrees <= 0 and not clockwise):
			start_rotate = false
			audio_stream_player_2d.stream = BRIDGE_STOP
			audio_stream_player_2d.play()
			for child: CollisionShape2D in moving_collisions.get_children():
				child.disabled = false
			self.rotation_degrees = 90 if clockwise else 0

func _on_body_entered(body):
	if not body is Player: 
		return
	body.on_bridge = true
	body.set_collision_layer_value(8, false)
	body.set_collision_mask_value(8, false)
	pass # Replace with function body.
	



func _on_body_exited(body):
	if not body is Player: 
		return
	body.on_bridge = false
	body.set_collision_layer_value(8, !body.character.flying)
	body.set_collision_mask_value(8, !body.character.flying)
	pass # Replace with function body.


func _on_area_entered(area):
	if not area is RessurectableArea:
		return
	area.reparent(self)
	pass # Replace with function body.
