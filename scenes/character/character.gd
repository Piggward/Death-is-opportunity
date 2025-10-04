class_name Character
extends Node2D

@export var movement_speed: float
@export var damage: float
@export var flying: bool
@export var health: float
@export var can_attack: bool
@export var has_special: bool
@export var attack_cd: float
@export var pre_attack_cd: float
@export var set_dead: bool
@export var ranged_attack: bool
@export var can_be_resurrected: bool = true
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_area = $AttackArea
@onready var hurtbox_area = $HurtboxArea
var dead = false
var enemy = false
@onready var resurrect_marker = $ResurrectMarker

signal died

func _ready():
	if get_parent() is Enemy:
		enemy = true
	if set_dead:
		animated_sprite_2d.die()

func resurrect():
	animated_sprite_2d.play_backwards("die")
	
func can_special():
	return true
	
func take_damage(damage):
	if dead or self is SoulCharacter:
		return
	self.health -= damage
	if health <= 0:
		die()
		return
	animated_sprite_2d.damage()
	
func spawn_ranged(dir):
	pass
		
func reset(is_enemy):
	enemy = is_enemy
	attack_area.reset()
	hurtbox_area.reset()
	dead = false
	z_index = 0
		
func die():
	dead = true
	attack_area.reset()
	z_index = 0
	died.emit()
	
func fade():
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite_2d, "self_modulate", Color(1, 1, 1, 0), 3)
	await tween.finished
	print("free")
	self.queue_free()
	
func _process(delta):
	self.global_rotation = 0
	
func special():
	pass
