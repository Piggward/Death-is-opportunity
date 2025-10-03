class_name SoulCharacter
extends Character

#@export var movement_speed: float
#@export var damage: float
#@export var flying: bool
#@export var health: float
#@export var can_attack: bool
#@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var soul_area = $SoulArea
@onready var animation_player = $AnimationPlayer

func resurrect():
	pass
	
func spawn_animation():
	self.scale = Vector2(0, 0)
	animation_player.play("spawn")
	animated_sprite_2d.play("spawn")
	await animated_sprite_2d.animation_finished
	if animation_player.is_playing():
		await animation_player.animation_finished
	self.scale = Vector2(1, 1)
	
func can_special():
	return soul_area.get_overlapping_areas().size() > 0
