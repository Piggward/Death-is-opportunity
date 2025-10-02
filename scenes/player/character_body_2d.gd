class_name Player
extends CharacterBody2D

var run_speed: float
var character_sprite: AnimatedSprite2D
@export var character: Character
var special_playing = false
@onready var player_state_machine = $PlayerStateMachine
var attack_cd = false
const ATTACK_CD = 0.4

func switch_bodies(new: Character):
	var old = character
	global_position = new.global_position
	new.reparent(self)
	character = new
	if old.has_special:
		remove_special()
	find_special()
	old.queue_free()
	run_speed = character.movement_speed
	character_sprite = character.animated_sprite_2d
	character.reset()
	
func on_attack():
	attack_cd = true
	await get_tree().create_timer(ATTACK_CD).timeout
	attack_cd = false
	
func _ready():
	run_speed = character.movement_speed
	character_sprite = character.animated_sprite_2d
	find_special()
	player_state_machine.init(self)
	character.died.connect(_on_character_dead)
	
func _on_character_dead():
	player_state_machine.current_state.dead()
	
func find_special():
	if character.has_special:
		for child in character.get_children():
			if child is PlayerState:
				child.reparent(player_state_machine)
				
func remove_special():
	for child: PlayerState in player_state_machine.get_children():
		if child.state == child.State.SPECIAL:
			child.queue_free()
			
	
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
	
