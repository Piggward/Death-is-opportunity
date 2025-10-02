class_name RessurectableArea
extends Area2D

@export var character: Character

func _ready():
	character.animated_sprite_2d.play("die")
