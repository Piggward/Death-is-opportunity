extends Label

const RESURRECT_TEXT = "PRESS SHIFT TO RESURRECT"
const DIE_TEXT = "PRESS SHIFT AGAIN TO DIE"
const FLY_ACTIVATION_TEXT = "YOUR CHARACTER IS TOO LIGHT TO TRIGGER THE PLATFORM"
@onready var tool_tip_container = $"../.."

func _ready():
	EventManager.can_resurrect.connect(_resurrect_tool_tip)
	EventManager.player_died.connect(_on_player_death)
	EventManager.flying_on_activation.connect(_on_flying_on_activation)
	tool_tip_container.visible = false
	self.text = ""
	
func _on_flying_on_activation():
	tool_tip_container.visible = true
	self.text = FLY_ACTIVATION_TEXT
	await get_tree().create_timer(2).timeout
	tool_tip_container.visible = false
	
func _on_player_death():
	if 	self.text == DIE_TEXT:
		tool_tip_container.visible = false
	
func _resurrect_tool_tip(value):
	if not value and text == RESURRECT_TEXT:
		tool_tip_container.visible = false
		if not EventManager.has_died and EventManager.has_resurrected:
			await get_tree().create_timer(4).timeout
			self.text = DIE_TEXT
			tool_tip_container.visible = true
	else: 
		tool_tip_container.visible = true 
		text = RESURRECT_TEXT
