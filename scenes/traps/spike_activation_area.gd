extends Area2D

@export var on: bool

const ITEMMAPLAYER = 0
const WORLDMAPLAYER = 1
var worldTileMap: TileMapLayer
var itemTileMap: TileMapLayer
const SPIKES_TILE = Vector2(19, 3)
const NO_SPIKES_TILE = Vector2(19, 2)
const LEVER_ON_TILE = Vector2(5, 13)
const LEVER_OFF_TILE = Vector2(6, 13)
const OPEN_DOOR_TILE = Vector2(17, 6)
const CLOSED_DOOR_TILE = Vector2(17, 5)
const BUTTON = Vector2(1, 13)
const PUSHED_BUTTON = Vector2(2, 13)
var cd = false
const SPIKES = preload("uid://b0hpnldho6nu8")
const LEVER_PULL = preload("uid://bjl12kgcp1wj1")
@onready var spikes = $Door
@onready var button = $Button
const BUTTON_PRESS = preload("uid://d4kauyeaq2x3a")
const BUTTON_UNPRESS = preload("uid://ckt6vv4isnpqr")

func _ready():
	worldTileMap = get_tree().get_first_node_in_group("WorldTileMap")
	itemTileMap = get_tree().get_first_node_in_group("ItemTileMapLayer")
	change()
	

func change():
	var lever_tile = BUTTON if not self.has_overlapping_areas() else PUSHED_BUTTON
	var spike_tile = SPIKES_TILE if not self.has_overlapping_areas() else NO_SPIKES_TILE
	
	var tile = (itemTileMap.local_to_map(self.global_position * 2));
	itemTileMap.set_cell(tile, ITEMMAPLAYER, lever_tile, 0)
	
	button.stream = BUTTON_UNPRESS if not self.has_overlapping_areas() else BUTTON_PRESS
	button.play()
	
	for child in get_children():
		if child is Marker2D:
			var tile2 = (worldTileMap.local_to_map(child.global_position));
			worldTileMap.set_cell(tile2, WORLDMAPLAYER, spike_tile, 0)
	spikes.stream = SPIKES
	spikes.pitch_scale = 0.7 if self.has_overlapping_areas() else 1
	spikes.play()
		

func _on_area_entered(area):
	change()
	pass # Replace with function body.


func _on_area_exited(area):
	change()
	pass # Replace with function body.
