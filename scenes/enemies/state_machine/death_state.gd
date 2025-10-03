extends EnemyState
const RESURRECTABLE_AREA = preload("uid://4upasttw8fh8")

func enter() -> void:
	enemy.animated_sprite.die()
	if enemy.character.can_be_resurrected:
		var area: RessurectableArea = RESURRECTABLE_AREA.instantiate()
		enemy.character.attack_area.monitoring = false
		area.character = enemy.character
		area.global_position = enemy.character.global_position
		get_tree().root.add_child(area)
		enemy.character.reparent(area)
	enemy.queue_free()
