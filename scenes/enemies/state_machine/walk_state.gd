extends EnemyState

var idle_area: Area2D
var target = Vector2.ZERO

func process(delta):
	if enemy.aggro_area.get_overlapping_bodies().size() > 0 and enemy.aggro_area.get_overlapping_bodies()[0].character is not SoulCharacter:
		transition_requested.emit(self, State.HUNT)
		return
	var distance = target - enemy.global_position 
	if distance.length() <= enemy.character.movement_speed * delta:
		enemy.global_position = target
		transition_requested.emit(self, EnemyState.State.IDLE)
		return
	else:
		#enemy.global_position += distance.normalized() * enemy.character.movement_speed
		enemy.global_position += distance.normalized() * enemy.character.movement_speed * delta
		
func enter() -> void:
	idle_area = enemy.idle_area
	target = random_point_in_idle_area()
	var distance = enemy.global_position - target
	if distance.y < 0:
		enemy.animated_sprite.walk_up()
	else:
		enemy.animated_sprite.walk_down()
		
	enemy.animated_sprite.set_flip_h(distance.x < 0)
	
func random_point_in_idle_area():
	var shape = idle_area.get_node("CollisionShape2D").shape
	var random_pos = Vector2.ZERO

	if shape is RectangleShape2D:
		var ext = shape.extents
		random_pos = Vector2(
			randf_range(-ext.x, ext.x),
			randf_range(-ext.y, ext.y)
		)
		
	# Add the Area2D's global position to get world coordinates
	random_pos += idle_area.global_position
	return random_pos + idle_area.get_node("CollisionShape2D").position
	
	
