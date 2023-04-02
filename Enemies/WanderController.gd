extends Node2D

var wander_range = 32
var tolerance = 2

@onready var initial_position = self.global_position
@onready var target_position = self.global_position

@onready var timer = $Timer

func get_time_left():
	return timer.time_left
	
func start_timer(time_sec: int):
	timer.start(time_sec)

func _on_timer_timeout():
	update_target_position()

func update_target_position():
	var target_vector = Vector2(
		randi_range(-wander_range, wander_range),
		randi_range(-wander_range, wander_range)
	)
	target_position = initial_position + target_vector
