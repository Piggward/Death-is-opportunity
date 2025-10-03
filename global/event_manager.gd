extends Node

var has_resurrected = false
var has_died = false

signal can_resurrect(value: bool)
signal player_died
signal flying_on_activation
