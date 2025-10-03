extends EnemyState
const RESURRECTABLE_AREA = preload("uid://4upasttw8fh8")

func enter() -> void:
	enemy.animated_sprite.die()
	var area: RessurectableArea = RESURRECTABLE_AREA.instantiate()
	enemy.character.attack_area.monitoring = false
	area.character = enemy.character
	get_tree().root.add_child(area)
	enemy.character.reparent(area)
