extends EnemyState

func process(delta):
	if enemy.aggro_area.get_overlapping_bodies().size() > 0:
		var char = enemy.aggro_area.get_overlapping_bodies()[0].character 
		if char is not SoulCharacter and not char.dead:
			transition_requested.emit(self, EnemyState.State.HUNT)
	pass
		
func enter() -> void:
	enemy.animated_sprite.idle()
	await get_tree().create_timer(randf_range(2, 5)).timeout
	transition_requested.emit(self, EnemyState.State.WALKING)
