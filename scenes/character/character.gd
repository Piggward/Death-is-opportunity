class_name Character
extends Node2D

@export var movement_speed: float
@export var damage: float
@export var flying: bool
@export var health: float
@export var can_attack: bool
@export var has_special: bool
@export var attack_cd: float
var res_pos: Vector2
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var resurrect_position = $Resurrect_Position
@onready var attack_area = $AttackArea
@onready var hurtbox_area = $HurtboxArea
var dead = false
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
	print("take damage")
	if dead:
		return
	self.health -= damage
	animated_sprite_2d.damage()
	if health <= 0:
		die()
		
func reset():
	if get_parent() is Enemy:
		enemy = true
	attack_area.reset()
	hurtbox_area.reset()
		
func die():
	dead = true
	died.emit()
	
func special():
	pass
