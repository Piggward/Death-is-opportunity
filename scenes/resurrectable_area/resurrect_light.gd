extends PointLight2D

var max = 2.5
var min = 0.3
var start = 1.5
var increasing = true
var speed = 2

func _ready():
	self.energy = 1.5

func _process(delta):
	if increasing: 
		self.energy += delta * speed
		increasing = self.energy < max
	else:
		self.energy -= delta * speed
		increasing = self.energy < min
