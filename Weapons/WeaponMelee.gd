extends Area2D

@onready var pivot = $SwingPivot
@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $SwingPivot/Sprite2D

func _process(delta):
	var mousePosition = get_global_mouse_position()
	look_at(mousePosition)
	
#	if mousePosition.x - global_position.x < 0:
#		sprite.scale.y = -0.5
#	else:
#		sprite.scale.y = 0.5

	if Input.is_action_just_pressed("attack"):
		animationPlayer.play("swing_melee_weapon")
