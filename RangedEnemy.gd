extends CharacterBody2D

@export var SPEED: int = 50
@export var FRICTION: int = 200

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var timer: Timer = $Timer
var target_marker: Marker2D

var target_position: Vector2
var target_tolerance: int = 10

var state = MOVE

enum {
	MOVE,
	IDLE
}

func _ready():
	target_marker = get_node("/root/Node2D/Marker2D")
	target_position = target_marker.global_position
	timer.start(1)

func _physics_process(delta: float):
	if target_position == null:
		state = IDLE
	else:
		state = MOVE

	match state:
		IDLE:
			handle_idle(delta)
		MOVE:
			handle_movement(delta)

func handle_idle(delta: float) -> void:
	pass
	
func handle_movement(delta: float) -> void:
	if global_position.distance_to(target_position) < target_tolerance:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		if velocity.distance_to(Vector2.ONE) < 5:
			state = IDLE
	
	var direction = global_position.direction_to(target_position)
	velocity += direction * SPEED * delta
	velocity.limit_length(SPEED)
	animation_tree.set("parameters/bird_fly/blend_position", direction)
	move_and_slide()
