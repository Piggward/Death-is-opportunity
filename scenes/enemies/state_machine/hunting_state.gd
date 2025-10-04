extends EnemyState

var aggro_area: Area2D
var target: Player
var ranged: bool
var ranged_position: Vector2

func process(delta):
	if ranged:
		ranged_logic(delta)
		return
	if not aggro_area.overlaps_body(target):
		transition_requested.emit(self, EnemyState.State.IDLE)
		return
	var distance = target.global_position - enemy.global_position 
	enemy.animated_sprite.set_flip_h(distance.x < 0)
	if distance.y < 0:
		enemy.animated_sprite.walk_up()
	else:
		enemy.animated_sprite.walk_down()
	if distance.length() <= 15 * enemy.character.scale.y:
		transition_requested.emit(self, EnemyState.State.ATTACK)
	else:
		enemy.global_position += distance.normalized() * enemy.character.movement_speed * delta
		
func ranged_logic(delta):
	var target_dist = 50
	if not aggro_area.overlaps_body(target):
		transition_requested.emit(self, EnemyState.State.IDLE)
		return
	var distance = target.global_position - enemy.global_position 
	enemy.animated_sprite.set_flip_h(distance.x < 0)
	if distance.y < 0:
		enemy.animated_sprite.walk_up()
	else:
		enemy.animated_sprite.walk_down()
	if (distance.length() <= 60 * enemy.character.scale.y) and (distance.length() >= 50 * enemy.character.scale.y):
		transition_requested.emit(self, EnemyState.State.ATTACK)
	else:
		var multiplier = -1 if distance.length() > target_dist else 1
		var move = (distance.normalized() * enemy.character.movement_speed * delta * multiplier)
		enemy.global_position = clamp_point(enemy.global_position - move)
		
func enter() -> void:
	EventManager.enemy_hunting.emit()
	aggro_area = enemy.aggro_area
	ranged = enemy.character.ranged_attack
	if enemy.type == enemy.EnemyType.BAT:
		enemy.animated_sprite.idle()
	target = aggro_area.get_overlapping_bodies()[0]
	
	
func clamp_point(point: Vector2):
	var col = enemy.idle_area.get_node("CollisionShape2D")
	var rect = col.shape.get_rect().size
	
	var max_y = col.global_position.y + rect.y / 2
	var min_y = col.global_position.y - rect.y / 2
	var max_x = col.global_position.x + rect.x / 2
	var min_x = col.global_position.x - rect.x / 2
	
	point.x = clamp(point.x, min_x, max_x)
	point.y = clamp(point.y, min_y, max_y)
	return point
	
func is_clamped(point: Vector2):
	var col = enemy.idle_area.get_node("CollisionShape2D")
	var rect = col.shape.get_rect().size
	
	var max_y = col.global_position.y + rect.y / 2
	var min_y = col.global_position.y - rect.y / 2
	var max_x = col.global_position.x + rect.x / 2
	var min_x = col.global_position.x - rect.x / 2
	return point.x == max_x or point.x == min_x or point.y == max_y or point.y == min_y
