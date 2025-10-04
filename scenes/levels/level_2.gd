extends Node2D

var animation_player: AnimationPlayer
@onready var music = $Music

func _ready():
	animation_player = get_tree().get_first_node_in_group("ui_animation_player")
	animation_player.play("fade_from_black")
	music.play()
	await get_tree().create_timer(6).timeout
	if not EventManager.has_died:
		EventManager.hint_death.emit()
