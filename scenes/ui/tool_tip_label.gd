extends Label

const RESURRECT_TEXT = "PRESS SHIFT TO RESURRECT"
const DIE_TEXT = "PRESS SHIFT TO DIE"
const FLY_ACTIVATION_TEXT = "YOUR CHARACTER IS TOO LIGHT TO TRIGGER THE PLATFORM"
const ATTACK_TEXT = "PRESS SPACE TO ATTACK"
const WRONG_CHARACTER = "YOU NEED TO PROCEED AS "
@onready var tool_tip_container = $"../.."

func _ready():
	EventManager.can_resurrect.connect(_resurrect_tool_tip)
	EventManager.player_died.connect(_on_player_death)
	EventManager.flying_on_activation.connect(_on_flying_on_activation)
	EventManager.hint_death.connect(_on_hint_death)
	EventManager.enemy_hunting.connect(_on_enemy_hunting)
	EventManager.player_resurrected.connect(_on_resurrect)
	EventManager.wrong_character.connect(_on_wrong_character)
	tool_tip_container.visible = false
	self.text = ""
	
func _on_wrong_character(name: String):
	tool_tip_container.visible = true
	self.text = WRONG_CHARACTER + name.to_upper()
	await get_tree().create_timer(2).timeout
	tool_tip_container.visible = false
	self.text = ""
	
func _on_resurrect():
	if not EventManager.has_died_after_res:
		self.text = DIE_TEXT + " AGAIN"
		tool_tip_container.visible = true
		EventManager.has_died_after_res = true
		return
	
func _on_enemy_hunting():
	if EventManager.has_been_hunted:
		return
	EventManager.has_been_hunted = true
	tool_tip_container.visible = true
	self.text = ATTACK_TEXT
	await EventManager.enemy_death
	if self.text == ATTACK_TEXT:
		tool_tip_container.visible = false
		self.text = ""
	
func _on_hint_death():
	tool_tip_container.visible = true
	self.text = DIE_TEXT
	
func _on_flying_on_activation():
	tool_tip_container.visible = true
	self.text = FLY_ACTIVATION_TEXT
	await get_tree().create_timer(2).timeout
	tool_tip_container.visible = false
	self.text = ""
	
func _on_player_death():
	if self.text.contains(DIE_TEXT):
		tool_tip_container.visible = false
		self.text = ""
	
func _resurrect_tool_tip(value):
	if not value and text == RESURRECT_TEXT:
		tool_tip_container.visible = false
		if not EventManager.has_died and EventManager.has_resurrected:
			await get_tree().create_timer(4).timeout
			self.text = DIE_TEXT
			tool_tip_container.visible = true
	elif self.text == "": 
		tool_tip_container.visible = true 
		text = RESURRECT_TEXT
