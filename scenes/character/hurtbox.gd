class_name Hurtbox
extends Area2D

@onready var character = $".."

const ENEMY_HURT_LAYER = 7
const PLAYER_HURT_LAYER = 6

func _ready():
	monitoring = false
	if character.enemy:
		self.collision_layer = ENEMY_HURT_LAYER
	else:
		self.collision_layer = PLAYER_HURT_LAYER
		
func take_damage(damage):
	character.take_damage(damage)
