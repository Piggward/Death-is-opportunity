class_name RessurectableArea
extends Area2D

@export var character: Character
@onready var resurrect_light = $ResurrectLight


func _on_child_entered_tree(node):
	if node is Character: 
		if not node.is_node_ready(): 
			await node.ready
		if not self.is_node_ready():
			await self.ready
		self.scale.x *= -1 if node.animated_sprite_2d.is_flipped_h() else 1
		self.scale *= node.scale
		resurrect_light.global_position = node.resurrect_marker.global_position
	pass # Replace with function body.
