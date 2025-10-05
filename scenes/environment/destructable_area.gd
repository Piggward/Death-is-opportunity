class_name DestructableArea
extends Area2D

@export var threshold: float
@export var tooltip_text: String
@onready var markers = $Markers
var tileMap: TileMapLayer
@onready var sound = $Sound
const WOOD_THUD = preload("uid://c1axjp58ilo3s")
const BREAK_TABLES = preload("uid://dqce75nljpm5x")
var destroyed = false

func _ready():
	tileMap = get_tree().get_first_node_in_group("PropsTileMap")
	
func take_damage(damage):
	if destroyed:
		return
	if damage < threshold:
		sound.stream = WOOD_THUD
		sound.play()
		EventManager.try_destroy.emit(tooltip_text)
	else: 
		destroyed = true
		sound.stream = BREAK_TABLES
		sound.play()
		for child in markers.get_children():
			tileMap.erase_cell(tileMap.local_to_map(child.global_position))
