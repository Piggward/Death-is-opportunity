class_name PlayerStateMachine
extends Node

@export var initial_state: PlayerState

var current_state: PlayerState
var states := {};

func init(player: Player) -> void:
	for child in get_children(): 
		if child is PlayerState: 
			states[child.state] = child;
			child.transition_requested.connect(_on_transition_requested)
			child.player = player
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func _on_transition_requested(from: PlayerState, to: PlayerState.State) -> void:
	if from != current_state:
		print("error1")
		return
	
	var new_state: PlayerState = states[to]
	if not new_state:
		print("error1: ", new_state.state)
		return
	
	if current_state:
		current_state.exit()
	
	print("entering state: ", new_state.state)
	new_state.enter()
	current_state = new_state


func _on_child_exiting_tree(node):
	if states[node.state]:
		states.erase(states[node.state])
	pass # Replace with function body.


func _on_child_entered_tree(node):
	if node is PlayerState:
		states[node.state] = node;
	pass # Replace with function body.
