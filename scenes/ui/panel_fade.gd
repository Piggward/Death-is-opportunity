extends Panel

var fade = false
var fade_in = false
@onready var animation_player = $"../AnimationPlayer"

func _ready():
	start_fade_out()
	
func start_fade_in():
	self.visible = true
	animation_player.play("feade")
	
func start_fade_out():
	animation_player.play_backwards("feade")
	
