extends Area2D

@onready var area_shape: CollisionShape2D = $CollisionShape2D
@onready var spawn_timer: Timer = $Timer
@onready var world_root: Window = get_node("/root")

@export var entity_limit: int = 6
@export var spawn_cooldown: int = 10
@export var enemy: PackedScene = null

## should correspond to enemy wander range if there is one
@export var spawn_area_margin: int = 10

var spawn_rect: Rect2

func _ready():
	spawn_rect = area_shape.shape.get_rect()

func _on_timer_timeout():
	var spawn_area_population: Array = get_overlapping_bodies()
	if spawn_area_population.size() < entity_limit:
		spawn_area_population = get_overlapping_bodies()
		var new_enemy = enemy.instantiate()
		world_root.add_child(new_enemy)
		
		var enemy_position = to_global(Vector2(
			randi_range(0 + spawn_area_margin, spawn_rect.size.x - spawn_area_margin), 
			randi_range(0 + spawn_area_margin, spawn_rect.size.y - spawn_area_margin)
		))
		new_enemy.set_initial_position(enemy_position)
		new_enemy.global_position = enemy_position
