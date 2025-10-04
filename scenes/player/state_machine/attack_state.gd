extends PlayerState

var character: Character 
var attack_cd = false

func enter():
	if attack_cd:
		return
	var dir = "up" if player.velocity.y < 0 else "down"
	character = player.character
	attack(dir)
	
func attack(dir):
	if not character.can_attack:
		return
	player.attacking = true
	character.attack_area.scale = Vector2(1 if not character.animated_sprite_2d.is_flipped_h() else -1, 1 if dir == "down" else -1)
	character.attack_area.enable()
	character.animated_sprite_2d.attack(dir)
	if character.ranged_attack:
		character.spawn_ranged(player.current_direction.normalized())
	await character.animated_sprite_2d.animation_finished
	character.attack_area.disable()
	attack_cd = true
	player.attacking = false
	await get_tree().create_timer(character.attack_cd).timeout
	attack_cd = false
	
func process(delta) -> void:
	if not player.attacking:
		finish()
		return
	
	player.walk()
	
func exit(): 
	character.attack_area.disable()
	
func finish():
	if player.velocity > Vector2.ZERO:
		transition_requested.emit(self, PlayerState.State.WALKING)
	else:
		transition_requested.emit(self, PlayerState.State.IDLE)
