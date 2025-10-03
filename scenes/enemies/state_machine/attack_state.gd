extends EnemyState

var attacking = false
var character: Character
var player: Player
var attack_cd = false

func enter():
	if attack_cd:
		return
	character = enemy.character
	player = enemy.aggro_area.get_overlapping_bodies()[0]
	attack()
	
func attack():
	if not character.can_attack:
		return
	attacking = true
	attack_cd = true
	await get_tree().create_timer(0.25).timeout
	var distance = player.global_position - enemy.global_position 
	var dir = "down" if distance.y > 0 else "up"
	character.attack_area.scale = Vector2(1 if not character.animated_sprite_2d.is_flipped_h() else -1, 1 if dir == "down" else -1)
	character.attack_area.monitoring = true
	character.animated_sprite_2d.attack(dir)
	await character.animated_sprite_2d.animation_finished
	character.attack_area.monitoring = false
	attacking = false
	await get_tree().create_timer(character.attack_cd).timeout
	attack_cd = false
	
func process(delta) -> void:
	if not attacking:
		finish()
		return
	
func exit(): 
	character.attack_area.monitoring = false
	
func finish():
	if enemy.aggro_area.get_overlapping_bodies().size() > 0  and enemy.aggro_area.get_overlapping_bodies()[0].character is not SoulCharacter:
		transition_requested.emit(self, EnemyState.State.HUNT)
	else:
		transition_requested.emit(self, EnemyState.State.IDLE)
