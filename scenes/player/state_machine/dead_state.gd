extends PlayerState

const RESURRECTABLE_AREA = preload("uid://4upasttw8fh8")

func enter() -> void:
	player.has_become_spirit.connect(_finish)
	player.animated_sprite.die()
	var area: RessurectableArea = RESURRECTABLE_AREA.instantiate()
	player.character.attack_area.monitoring = false
	area.character = player.character
	get_tree().root.add_child(area)
	player.character.reparent(area)
	
	player.become_spirit()
	
func _finish():
	transition_requested.emit(self, PlayerState.State.IDLE)
	
func exit():
	player.has_become_spirit.disconnect(_finish)
