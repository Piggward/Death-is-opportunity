extends Area2D

@onready var darkness = $Darkness

func _on_body_entered(body):
	for child in get_children():
		if child is PointLight2D and child.name == "Darkness":
			child.visible = false
	pass # Replace with function body.
