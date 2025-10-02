class_name RessurectableArea
extends Area2D

@export var sprite_frames: SpriteFrames
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready(): 
	animated_sprite_2d.sprite_frames = sprite_frames
	animated_sprite_2d.play("die")
