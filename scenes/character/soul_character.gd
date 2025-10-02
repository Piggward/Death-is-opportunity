class_name SoulCharacter
extends Character

#@export var movement_speed: float
#@export var damage: float
#@export var flying: bool
#@export var health: float
#@export var can_attack: bool
#@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var soul_area = $SoulArea

func resurrect():
	pass
	
func can_special():
	return soul_area.get_overlapping_areas().size() > 0
