class_name Player
extends CharacterBody2D

var run_speed: float
var character_sprite: AnimatedSprite2D
@export var character: Character
@onready var player_state_machine = $PlayerStateMachine
var attack_cd = false
const ATTACK_CD = 0.4

signal has_become_spirit

func switch_bodies(new: Character):
	var old = character
	global_position = new.global_position
	new.reparent(self)
	character = new
	old.queue_free()
	set_character()
	
func on_attack():
	attack_cd = true
	await get_tree().create_timer(ATTACK_CD).timeout
	attack_cd = false
	
func _ready():
	set_character()
	player_state_machine.init(self)
	
func set_character():
	run_speed = character.movement_speed
	character_sprite = character.animated_sprite_2d
	character.died.connect(_on_character_dead)
	character.reset()
	
func _on_character_dead():
	player_state_machine.current_state.dead()
	character.died.disconnect(_on_character_dead)
	
func become_spirit():
	var soul_character = load("uid://bpbar0ooab80q")
	var soul = soul_character.instantiate()
	self.character = soul
	add_child(soul)
	await soul.spawn_animation()
	self.global_position = soul.global_position
	soul.position = Vector2.ZERO
	set_character()
	has_become_spirit.emit()
	
func take_damage():
	character_sprite.damage()

func _physics_process(delta):
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
	
