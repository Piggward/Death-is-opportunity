extends Area2D

var start_rotate = false
var start_rotation = 0
var clockwise: bool
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
const BRIDGE_MOVING = preload("uid://csnnofbp8a38b")
const BRIDGE_STOP = preload("uid://rbfbk4ncnonm")
@onready var static_body_2d = $StaticBody2D
@onready var move = $Move

#func _ready():
	#for child in static_body_2d.get_children():
		#if child.name.contains("Move"):
			#child.disabled = !child.disabled
	#await get_tree().create_timer(1).timeout
	#_ready()
	


func _rotate(value: bool):
	start_rotate = true
	move.position = Vector2.ZERO
	audio_stream_player_2d.stream = BRIDGE_MOVING
	audio_stream_player_2d.play()
	clockwise = value;
	
	
func _process(delta):
	if start_rotate:
		self.rotation_degrees += 20 * delta if clockwise else -20 * delta
		if (self.rotation_degrees >= 90 and clockwise) or (self.rotation_degrees <= 0 and not clockwise):
			self.rotation_degrees = 90 if clockwise else 0
			audio_stream_player_2d.stream = BRIDGE_STOP
			audio_stream_player_2d.play()
			start_rotate = false
			move.position = Vector2(9999, 9999)

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
