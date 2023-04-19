extends Area2D

@onready var pivot = $SwingPivot
@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $SwingPivot/Sprite2D
@onready var hitboxCollision = $SwingPivot/Sprite2D/Hitbox

func _process(delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	var attack_animation_used
	
	if mouse_position.x < global_position.x:
		attack_animation_used = "swing_melee_weapon_inverted"
	else:
		attack_animation_used = "swing_melee_weapon"

	if Input.is_action_just_pressed("attack"):
		animationPlayer.play(attack_animation_used)
