extends PlayerState

func process(delta):
	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	
	if Input.is_action_just_pressed("attack") and not player.attacking: 
		transition_requested.emit(self, State.ATTACK)
	if Input.is_action_just_pressed("special") and player.character.can_special():
		transition_requested.emit(self, State.SPECIAL)
	elif x_direction or y_direction:
		transition_requested.emit(self, State.WALKING)
		
func enter() -> void:
	player.velocity = Vector2.ZERO
	player.character_sprite.idle()
	
