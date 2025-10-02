extends EnemyState

var aggro_area: Area2D
var target: Player

func process(delta):
	if not aggro_area.overlaps_body(target):
		transition_requested.emit(self, EnemyState.State.IDLE)
		return
	var distance = target.global_position - enemy.global_position 
	enemy.animated_sprite.set_flip_h(distance.x < 0)
	if distance.length() <= 15:
		transition_requested.emit(self, EnemyState.State.ATTACK)
	else:
		enemy.global_position += distance.normalized() * enemy.character.movement_speed * delta
		
func enter() -> void:
	aggro_area = enemy.aggro_area
	enemy.animated_sprite.idle()
	target = aggro_area.get_overlapping_bodies()[0]
	
