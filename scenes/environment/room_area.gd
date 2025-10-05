class_name BridgeArea
extends Area2D

@onready var darkness = $Darkness
var has_entered = false

func _ready():
	for child in get_children():
		if child is PointLight2D and child.name.contains("Darkness"):
			child.visible = true
	for child in get_children():
		if child is PointLight2D and child.name.contains("PointLight"):
			child.visible = false
			
func _process(delta):
	if not has_entered:
		return
	for child in get_children():
		if child is PointLight2D and child.name.contains("Darkness"):
			child.energy = clamp(child.energy - delta * 3, 0, 1)
			if child.energy == 0:
				child.queue_free()

func _on_body_entered(body):
	has_entered = true
	for child in get_children():
		if child is PointLight2D and child.name.contains("PointLight"):
			child.visible = true
	pass # Replace with function body.
