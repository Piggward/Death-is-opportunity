extends Area2D

const ITEMMAPLAYER = 0
const WORLDMAPLAYER = 1
@export var original_tile: Vector2
@export var changing_tile: Vector2
@export var time: float
var itemTileMap: TileMapLayer
var worldTileMap: TileMapLayer
@onready var door_marker = $Marker2D
const OPEN_DOOR_TILE = Vector2(17, 6)
const CLOSED_DOOR_TILE = Vector2(17, 5)
const SPIKES_TILE = Vector2(19, 3)
const NO_SPIKES_TILE = Vector2(19, 2)
const LEVER_ON_TILE = Vector2(5, 13)
const LEVER_OFF_TILE = Vector2(6, 13)
@export var on = false
var cd = false

func _ready():
	itemTileMap = get_tree().get_first_node_in_group("ItemTileMapLayer")
	worldTileMap = get_tree().get_first_node_in_group("WorldTileMap")
	
func open_door():
	var tile = (worldTileMap.local_to_map(door_marker.global_position));
	worldTileMap.set_cell(tile, WORLDMAPLAYER, OPEN_DOOR_TILE, 0)
	
func close_door():
	var tile = (worldTileMap.local_to_map(door_marker.global_position));
	worldTileMap.set_cell(tile, WORLDMAPLAYER, CLOSED_DOOR_TILE, 0)
	
func change():
	var lever_tile = LEVER_OFF_TILE if not on else LEVER_ON_TILE
	
	var tile = (itemTileMap.local_to_map(self.global_position * 2));
	itemTileMap.set_cell(tile, ITEMMAPLAYER, lever_tile, 0)
	
	if on:
		open_door()
	else:
		close_door()
		
func _on_area_entered(area):
	if cd:
		return
	cd = true
	on = !on
	change()
	await get_tree().create_timer(time).timeout
	on = !on
	change()
	cd = false
	pass # Replace with function body.
