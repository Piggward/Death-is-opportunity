extends Area2D

@export var required_character = "";
@export var next_scene: PackedScene
var animation_player: AnimationPlayer

func _ready():
	animation_player = get_tree().get_first_node_in_group("ui_animation_player")

func _on_body_entered(body):
	if required_character == "Human":
		pass
	if body is Player:
		if not body.character.name.contains(required_character):
			EventManager.wrong_character.emit(required_character)
			return
		animation_player.play("fade_to_black")
		await animation_player.animation_finished
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
	pass # Replace with function body.
