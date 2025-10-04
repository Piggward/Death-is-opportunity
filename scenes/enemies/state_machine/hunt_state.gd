extends PlayerState

func process(delta):
	if Input.is_action_just_pressed("attack") and not player.attacking:
		transition_requested.emit(self, PlayerState.State.ATTACK)
	
	if Input.is_action_just_pressed("special") and player.character.can_special():
		transition_requested.emit(self, State.SPECIAL)
		
	player.walk()
	if player.velocity == Vector2.ZERO:
		transition_requested.emit(self, PlayerState.State.IDLE)
	else:
		player.character_sprite.set_flip_h(player.velocity.x < 0)
		if player.velocity.y < 0:
			player.character_sprite.walk_up()
		else:
			player.character_sprite.walk_down()
