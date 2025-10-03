class_name BatCharacter
extends Character

@onready var animated_sprite_2d_2 = $AnimatedSprite2D2

func reset():
	animated_sprite_2d_2.visible = true
	super()
	
func die():
	animated_sprite_2d_2.visible = false
	super()
