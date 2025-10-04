class_name Player
extends CharacterBody2D

var run_speed: float
var character_sprite: AnimatedSprite2D
@export var character: Character
@onready var player_state_machine = $PlayerStateMachine
var attack_cd = false
const ATTACK_CD = 0.4
var tween: Tween
var attacking = false
var current_direction: Vector2
var on_bridge = false
signal has_become_spirit
@onready var collision_shape_2d = $CollisionShape2D

func switch_bodies(new: Character, pos: Vector2):
	var old = character
	new.global_position = pos
	self.global_position = pos
	character = new
	set_character()
	new.reparent(self)
	get_tree().get_first_node_in_group("SoulPanel").start_fade_out()
	old.queue_free()
	EventManager.player_resurrected.emit()
	
func on_attack():
	attack_cd = true
	await get_tree().create_timer(ATTACK_CD).timeout
	attack_cd = false
	
func _ready():
	current_direction = Vector2(1, 0)
	set_character()
	player_state_machine.init(self)
	
func set_character():
	self.set_collision_layer_value(8, !character.flying and not on_bridge)
	self.set_collision_mask_value(8, !character.flying and not on_bridge)
	run_speed = character.movement_speed
	character_sprite = character.animated_sprite_2d
	character.died.connect(_on_character_dead)
	character.reset(false)
	collision_shape_2d.scale = character.scale
	
func _on_character_dead():
	player_state_machine.current_state.dead()
	character.died.disconnect(_on_character_dead)
	EventManager.player_died.emit()
	
func become_spirit():
	var og_pos = self.global_position
	var soul_character = load("uid://bpbar0ooab80q")
	var soul = soul_character.instantiate()
	self.character = soul
	add_child(soul)
	get_tree().get_first_node_in_group("SoulPanel").start_fade_in()
	await soul.spawn_animation()
	soul.global_position = og_pos
	soul.position = Vector2.ZERO
	self.global_position = og_pos
	set_character()
	soul.reset(true)
	has_become_spirit.emit()
	
func take_damage():
	character_sprite.damage()

func _physics_process(delta):
	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	current_direction = current_direction if Vector2(x_direction, y_direction) == Vector2.ZERO else Vector2(x_direction, y_direction)
	player_state_machine.current_state.process(delta)
	move_and_slide()
	
func walk():
	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	if x_direction:
		velocity.x = x_direction * run_speed
	else:
		velocity.x = move_toward(velocity.x, 0, run_speed)
	if y_direction:
		velocity.y = y_direction * run_speed
	else:
		velocity.y = move_toward(velocity.y, 0, run_speed)
	
