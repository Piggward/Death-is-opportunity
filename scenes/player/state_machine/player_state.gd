class_name PlayerState
extends Node

enum State { IDLE, ATTACK, WALKING, SPECIAL, DEAD, RESURRECTING }

signal transition_requested(from: PlayerState, to: State)

@export var state: State

var player: Player

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process(delta): 
	pass
