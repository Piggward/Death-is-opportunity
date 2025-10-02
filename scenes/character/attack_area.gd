class_name AttackArea
extends Area2D

@onready var character = $".."

const ENEMY_HURT_LAYER = 7
const PLAYER_HURT_LAYER = 6

func _ready():
	if character.enemy:
		self.collision_layer = PLAYER_HURT_LAYER
	else:
		self.collision_layer = ENEMY_HURT_LAYER
		


func _on_area_entered(area):
	area.take_damage(character.damage)
	pass # Replace with function body.
