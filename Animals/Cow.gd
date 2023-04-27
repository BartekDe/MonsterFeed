extends CharacterBody2D

@export var player: CharacterBody2D

var is_following_player: bool = false
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _process(delta):
	if is_following_player:
		self.global_position = player.global_position

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		is_following_player = !is_following_player
		collision_shape.disabled = !collision_shape.disabled
