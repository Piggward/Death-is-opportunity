extends PlayerState

var soul_area: Area2D
var resurrecting_area: RessurectableArea
var resurrecting_character: Character
var started = false

func enter():
	player.velocity = Vector2.ZERO
	soul_area = player.character.soul_area;

	resurrecting_area = soul_area.get_overlapping_areas()[0]
	resurrecting_character = resurrecting_area.character
	
func process(delta):
	player.velocity = Vector2.ZERO
	if not started: 
		started = true
		await soul_animation()
		
func soul_animation():
	var tween = get_tree().create_tween()
	tween.tween_property(player, "global_position", resurrecting_character.global_position + resurrecting_character.res_pos + player.character_sprite.position, 1.2)
	tween.play()
	player.character_sprite.special()
	await player.character_sprite.animation_finished
	player.character.visible = false
	resurrecting_character.resurrect()
	await resurrecting_character.animated_sprite_2d.animation_finished
	resurrecting_area.queue_free()
	transition_requested.emit(self, PlayerState.State.IDLE)
	player.switch_bodies(resurrecting_character)
