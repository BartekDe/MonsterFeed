extends Control

@onready var coins_label: Label = $CoinsLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.update_coins_ui.connect(update_counter)

func update_counter(current_coins: int) -> void:
	coins_label.text = "Coins: " + str(current_coins)
