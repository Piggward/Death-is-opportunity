extends EnemyState

func process(delta):
	if enemy.aggro_area.get_overlapping_bodies().size() > 0:
		transition_requested.emit(self, State.HUNT)
	pass
		
func enter() -> void:
	enemy.animated_sprite.idle()
	await get_tree().create_timer(randf_range(2, 5)).timeout
	transition_requested.emit(self, EnemyState.State.WALKING)
