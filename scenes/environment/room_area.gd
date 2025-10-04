class_name BridgeArea
extends Area2D

@onready var darkness = $Darkness

func _ready():
	for child in get_children():
		if child is PointLight2D and child.name.contains("Darkness"):
			child.visible = true
	for child in get_children():
		if child is PointLight2D and child.name.contains("PointLight"):
			child.visible = false

func _on_body_entered(body):
	for child in get_children():
		if child is PointLight2D and child.name.contains("Darkness"):
			child.visible = false
	for child in get_children():
		if child is PointLight2D and child.name.contains("PointLight"):
			child.visible = true
	pass # Replace with function body.
