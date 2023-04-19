extends Resource

class_name CoinStorage

var current_coins: int = 0

func _init():
	Events.coin_picked_up.connect(add_coins)

func add_coins(coins: int):
	current_coins += coins
	Events.update_coins_ui.emit(current_coins)
