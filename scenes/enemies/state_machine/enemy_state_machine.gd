class_name EnemyStateMachine
extends Node

@export var initial_state: EnemyState

var current_state: EnemyState
var states := {};

func init(enemy: Enemy) -> void:
	for child in get_children(): 
		if child is EnemyState: 
			states[child.state] = child;
			child.transition_requested.connect(_on_transition_requested)
			child.enemy = enemy
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func _on_transition_requested(from: EnemyState, to: EnemyState.State) -> void:
	if from != current_state:
		print("error1: ", from)
		return
	
	var new_state: EnemyState = states[to]
	if not new_state:
		print("error1: ", new_state.state)
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state


#func _on_child_exiting_tree(node):
	#if states[node.state]:
		#states.erase(states[node.state])
	#pass # Replace with function body.
#
#
#func _on_child_entered_tree(node):
	#if node is PlayerState:
		#states[node.state] = node;
	#pass # Replace with function body.
