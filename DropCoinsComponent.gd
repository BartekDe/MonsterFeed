extends Node2D

@export var coins_amount: int = 3

var coin_scene = preload("res://Enemies/Coin.tscn")

func drop_coins() -> void:
	for i in range(coins_amount):
		var coin = coin_scene.instantiate()
		coin.global_position = global_position + Vector2(randi_range(-10, 10), randi_range(-10, 10))
		get_parent().get_parent().add_child(coin)
