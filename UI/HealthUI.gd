extends Control

@onready var heartUIFull = $HeartUIFull
@onready var heartUIEmpty = $HeartUIEmpty
@export var heart_width = 15

var hearts = 4:
	set(new_hearts):
		hearts = clamp(new_hearts, 0, max_hearts)
		self.heartUIFull.size.x = hearts * self.heart_width

var max_hearts = 4:
	set(new_max_hearts):
		max_hearts = max(new_max_hearts, 1)
		self.heartUIEmpty.size.x = max_hearts * self.heart_width

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.health_changed.connect(set_hearts)
	
func set_hearts(new_hearts):
	self.hearts = new_hearts
