extends Item

class_name HealthPotion

var heal_amount: int = 1

func heal() -> void:
	Events.heal_player.emit(heal_amount)

func use_item() -> bool:
	heal()
	return true
