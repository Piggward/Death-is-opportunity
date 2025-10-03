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

func _ready():
	itemTileMap = get_tree().get_first_node_in_group("ItemTileMapLayer")
	worldTileMap = get_tree().get_first_node_in_group("WorldTileMap")
	
func open_door():
	var tile = (worldTileMap.local_to_map(door_marker.global_position));
	worldTileMap.set_cell(tile, WORLDMAPLAYER, OPEN_DOOR_TILE, 0)
	
func close_door():
	var tile = (worldTileMap.local_to_map(door_marker.global_position));
	worldTileMap.set_cell(tile, WORLDMAPLAYER, CLOSED_DOOR_TILE, 0)
	
func _on_area_entered(area):
	if area.get_parent().flying:
		EventManager.flying_on_activation.emit()
		return
	var tile = (itemTileMap.local_to_map(self.global_position * 2));
	itemTileMap.set_cell(tile, ITEMMAPLAYER, changing_tile, 0)
	open_door()
	pass # Replace with function body.


func _on_area_exited(area):
	if area.get_parent().flying:
		return
	var tile = (itemTileMap.local_to_map(self.global_position * 2));
	itemTileMap.set_cell(tile, ITEMMAPLAYER, original_tile, 0)
	close_door()
	pass # Replace with function body.
