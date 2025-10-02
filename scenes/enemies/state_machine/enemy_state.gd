class_name EnemyState
extends Node

enum State { IDLE, ATTACK, WALKING, HUNT, SPECIAL, DEAD, RESURRECTING }

signal transition_requested(from: EnemyState, to: State)

@export var state: State

var enemy: Enemy

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process(delta): 
	pass
