extends EnemyState
const RESURRECTABLE_AREA = preload("uid://4upasttw8fh8")

func enter() -> void:
	enemy.animated_sprite.die()
	var area: RessurectableArea = RESURRECTABLE_AREA.instantiate()
	area.character = enemy.character
