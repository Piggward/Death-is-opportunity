class_name Enemy
extends Area2D

const BAT_CHARACTER = preload("uid://b1u3xumenb4st")
var character: Character
@export var type: EnemyType
@export var idle_area: Area2D
@export var aggro_area: Area2D
var animated_sprite: CharacterSprite
@onready var enemy_state_machine = $EnemyStateMachine

enum EnemyType { BAT, WARG }

var character_dict = { 0: BAT_CHARACTER }

func _ready():
	var nc = character_dict[type].instantiate()
	add_child(nc)
	character = nc
	animated_sprite = character.animated_sprite_2d
	enemy_state_machine.init(self)
	character.died.connect(_on_character_dead)
	pass

func _on_character_dead():
	enemy_state_machine.current_state.dead()
	
func _process(delta):
	enemy_state_machine.current_state.process(delta)
	
