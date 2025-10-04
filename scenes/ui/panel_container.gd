extends PanelContainer

func _ready():
	EventManager.win_game.connect(_on_win)
	
func _on_win():
	self.visible = true
	get_tree().paused = true
