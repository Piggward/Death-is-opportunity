extends Node

var has_resurrected = false
var has_died = false
var has_been_hunted = false
var has_died_after_res = false

signal can_resurrect(value: bool)
signal player_died
signal flying_on_activation
signal hint_death
signal enemy_hunting
signal enemy_death
signal win_game
signal player_resurrected
signal wrong_character(value: String)
