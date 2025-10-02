extends PlayerState

var attacking = false
var character: Character 
func enter():
	var dir = "up" if player.velocity.y < 0 else "down"
	character = player.character
	attack(dir)
	
func attack(dir):
	if not character.can_attack:
		return
	attacking = true
	character.attack_area.scale = Vector2(1 if not character.animated_sprite_2d.is_flipped_h() else -1, 1 if dir == "down" else -1)
	character.attack_area.monitoring = true
	character.animated_sprite_2d.attack(dir)
	await character.animated_sprite_2d.animation_finished
	character.attack_area.monitoring = false
	attacking = false
	
func process(delta) -> void:
	if not attacking:
		finish()
		return
	
	player.walk()
	
func exit(): 
	character.attack_area.monitoring = false
	
func finish():
	if player.velocity > Vector2.ZERO:
		transition_requested.emit(self, PlayerState.State.WALKING)
	else:
		transition_requested.emit(self, PlayerState.State.IDLE)
