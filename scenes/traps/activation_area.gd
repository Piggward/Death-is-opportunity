extends Area2D

const ITEMMAPLAYER = 0
const WORLDMAPLAYER = 1
@export var original_tile: Vector2
@export var changing_tile: Vector2
var itemTileMap: TileMapLayer
var worldTileMap: TileMapLayer
@onready var door_marker = $Marker2D
const OPEN_DOOR_TILE = Vector2(17, 6)
const CLOSED_DOOR_TILE = Vector2(17, 5)
var open = false
@onready var door_audio = $Door
@onready var button_audio = $Button
const BUTTON_PRESS = preload("uid://d4kauyeaq2x3a")
const BUTTON_UNPRESS = preload("uid://ckt6vv4isnpqr")
const DOOR_CLOSE = preload("uid://d3omylgwoh8tp")
const DOOR_OPEN = preload("uid://bcqat7g2k1vej")


func _ready():
	itemTileMap = get_tree().get_first_node_in_group("ItemTileMapLayer")
	worldTileMap = get_tree().get_first_node_in_group("WorldTileMap")
	
func open_door():
	if open:
		return
	open = true
	var tile = (worldTileMap.local_to_map(door_marker.global_position));
	worldTileMap.set_cell(tile, WORLDMAPLAYER, OPEN_DOOR_TILE, 0)
	door_audio.stream = DOOR_OPEN
	door_audio.play()
	
func close_door():
	if not open:
		return
	open = false
	var tile = (worldTileMap.local_to_map(door_marker.global_position));
	worldTileMap.set_cell(tile, WORLDMAPLAYER, CLOSED_DOOR_TILE, 0)
	door_audio.stream = DOOR_CLOSE
	door_audio.play()
	
func _on_area_entered(area):
	if area.get_parent().flying and not open:
		EventManager.flying_on_activation.emit()
		return
	var tile = (itemTileMap.local_to_map(self.global_position * 2));
	itemTileMap.set_cell(tile, ITEMMAPLAYER, changing_tile, 0)
	
	open_door()
	pass # Replace with function body.


func _on_area_exited(area):
	if area.get_parent().flying:
		return
	for a in get_overlapping_areas():
		if not a.get_parent().flying:
			return
	var tile = (itemTileMap.local_to_map(self.global_position * 2));
	itemTileMap.set_cell(tile, ITEMMAPLAYER, original_tile, 0)
	button_audio.stream = BUTTON_UNPRESS
	button_audio.play()
	close_door()
	pass # Replace with function body.
