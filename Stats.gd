extends Node

@export var max_health: int = 1
@onready var health = max_health

signal no_health
signal health_changed(new_health: int)

func _ready():
	Events.heal_player.connect(heal)

func inflict_damage(amount):
	self.health -= amount
	emit_signal("health_changed", self.health)
	if self.health <= 0:
		emit_signal("no_health")
		
func heal(amount):
	self.health = clamp(self.health + amount, self.health, max_health)
	emit_signal("health_changed", self.health)
