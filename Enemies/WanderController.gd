extends Node2D

@export var wander_range: int = 15
@export var tolerance: int = 2

@onready var initial_position: Vector2 = self.global_position
@onready var target_position: Vector2 = self.global_position

@onready var timer = $Timer

func get_time_left() -> float:
	return timer.time_left
	
func start_timer(time_sec: int) -> void:
	timer.start(time_sec)

func _on_timer_timeout() -> void:
	update_target_position()

func update_target_position() -> void:
	var target_vector = Vector2(
		randi_range(-wander_range, wander_range),
		randi_range(-wander_range, wander_range)
	)
	target_position = initial_position + target_vector

func set_initial_position(new_initial_position: Vector2) -> void:
	initial_position = new_initial_position
