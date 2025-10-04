extends Area2D

@export var on: bool

const ITEMMAPLAYER = 0
const WORLDMAPLAYER = 1
@export var spike_tile: Vector2
@export var retract_tile: Vector2
var worldTileMap: TileMapLayer
var itemTileMap: TileMapLayer
const SPIKES_TILE = Vector2(19, 3)
const NO_SPIKES_TILE = Vector2(19, 2)
const LEVER_ON_TILE = Vector2(5, 13)
const LEVER_OFF_TILE = Vector2(6, 13)
var cd = false
@onready var bridge = $"../Bridge"

func _ready():
	worldTileMap = get_tree().get_first_node_in_group("WorldTileMap")
	itemTileMap = get_tree().get_first_node_in_group("ItemTileMapLayer")
	change()
	

func change():
	var lever_tile = LEVER_OFF_TILE if not on else LEVER_ON_TILE
	
	var tile = (itemTileMap.local_to_map(self.global_position * 2));
	itemTileMap.set_cell(tile, ITEMMAPLAYER, lever_tile, 0)
		

func _on_area_entered(area):
	if cd:
		return
	on = !on
	var cd = true
	change()
	bridge._rotate(on)
	await get_tree().create_timer(2).timeout
	cd = false
	pass # Replace with function body.
