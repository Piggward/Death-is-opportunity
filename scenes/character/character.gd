class_name Character
extends Node2D

@export var movement_speed: float
@export var damage: float
@export var flying: bool
@export var health: float
@export var can_attack: bool
@export var has_special: bool
var res_pos: Vector2
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var resurrect_position = $Resurrect_Position
@onready var attack_area = $AttackArea
var enemy = false

signal died

func _ready():
	if resurrect_position:
		res_pos = resurrect_position.position
	if get_parent() is Enemy:
		enemy = true

func resurrect():
	animated_sprite_2d.play_backwards("die")
	
func can_special():
	pass
	
func take_damage(damage):
	self.health -= damage
	animated_sprite_2d.damage()
	if health <= 0:
		die()
		
func die():
	animated_sprite_2d.die()
	died.emit()
	
func special():
	pass
