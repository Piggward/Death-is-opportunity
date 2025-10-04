class_name RangedAttack
extends Area2D

@export var direction: Vector2
@export var speed: float
@export var enemy: bool
@export var damage: int
var ma_layer: int
var c_layer: int
const ENEMY_ATTACK_LAYER = 9
const PLAYER_ATTACK_LAYER = 10
const ENEMY_HURT_LAYER = 7
const PLAYER_HURT_LAYER = 6

func _ready():
	if enemy:
		set_collision_layer_value(ENEMY_ATTACK_LAYER, true)
		set_collision_mask_value(PLAYER_HURT_LAYER, true)
		set_collision_mask_value(PLAYER_ATTACK_LAYER, true)
	else:
		set_collision_layer_value(PLAYER_ATTACK_LAYER, true)
		set_collision_mask_value(ENEMY_HURT_LAYER, true)
		speed = 75
	await get_tree().create_timer(2.5).timeout
	self.queue_free()


func _process(delta):
	self.global_position += direction * speed * delta


func _on_area_entered(area):
	if area is RangedAttack:
		return
	if area is HurtboxArea:
		area.take_damage(damage)
		self.queue_free()
	elif area is AttackArea and enemy:
		self.direction *= -1
		self.speed *= 4
		set_collision_layer_value(PLAYER_ATTACK_LAYER, true)
		set_collision_mask_value(ENEMY_HURT_LAYER, true)
	pass # Replace with function body.


func _on_body_entered(body):
	self.queue_free()
	pass # Replace with function body.
