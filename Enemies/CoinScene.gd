extends Area2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@export var coin_resource: Coin

func _ready():
	anim_player.play("pop_coin", -1, 1.5)

func play_idle_anim():
	anim_player.play("idle_coin")
	anim_player.seek(randf_range(0.0, 1.0))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Events.coin_picked_up.emit(coin_resource.coin_value)
		queue_free()
