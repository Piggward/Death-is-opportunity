class_name PumpkinCharacter
extends Character

const RANGED = preload("uid://d2s2i570s6wet")

func spawn_ranged(dir):
	var ranged = RANGED.instantiate()
	ranged.enemy = self.enemy
	ranged.direction = dir
	ranged.damage = damage
	ranged.global_position = self.global_position
	get_tree().root.add_child(ranged)
