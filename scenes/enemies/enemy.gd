extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	await get_tree().create_timer(7).timeout
	_on_death()
	pass

func _on_hit():
	animated_sprite_2d.play("Dmg")
	
func _on_death():
	animated_sprite_2d.play("Die")
	
func _on_attack():
	animated_sprite_2d.play("Attack")


func _on_body_entered(body):
	_on_attack();
	pass # Replace with function body.
