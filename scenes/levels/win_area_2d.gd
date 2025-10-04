extends Area2D


func _on_body_entered(body):
	EventManager.win_game.emit()
	pass # Replace with function body.
