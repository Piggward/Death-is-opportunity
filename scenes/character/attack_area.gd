class_name AttackArea
extends Area2D

@onready var character = $".."

const ENEMY_HURT_LAYER = 7
const PLAYER_HURT_LAYER = 6

func _ready():
	reset()
		
func reset():
	if not character.is_node_ready():
		await character.ready
	if character.enemy:
		self.set_collision_mask_value(PLAYER_HURT_LAYER, true)
	else:
		self.set_collision_mask_value(ENEMY_HURT_LAYER, true)

func _on_area_entered(area):
	area.take_damage(character.damage)
	pass # Replace with function body.
