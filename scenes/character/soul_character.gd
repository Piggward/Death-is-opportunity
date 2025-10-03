class_name SoulCharacter
extends Character

#@export var movement_speed: float
#@export var damage: float
#@export var flying: bool
#@export var health: float
#@export var can_attack: bool
#@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var soul_area = $SoulArea
@onready var animation_player = $AnimationPlayer

func resurrect():
	pass
	
func spawn_animation():
	self.scale = Vector2(0, 0)
	animation_player.play("spawn")
	animated_sprite_2d.play("spawn")
	await animated_sprite_2d.animation_finished
	if animation_player.is_playing():
		await animation_player.animation_finished
	self.scale = Vector2(1, 1)
	
func reset():
	self.attack_area.monitoring = false
	self.attack_area.monitorable = false
	self.hurtbox_area.monitoring = false
	self.hurtbox_area.monitorable = false
	get_tree().get_first_node_in_group("SoulPanel").visible = true
	
func can_special():
	return soul_area.get_overlapping_areas().size() > 0
	


func _on_soul_area_area_entered(area):
	EventManager.can_resurrect.emit(true)
	pass # Replace with function body.


func _on_soul_area_area_exited(area):
	EventManager.can_resurrect.emit(false)
	pass # Replace with function body.
