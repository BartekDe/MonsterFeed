extends Resource

class_name ExperienceLevel

const LEVEL_UP_REQUIREMENTS = {
	1: 5,
	2: 12,
	3: 18
}

var level: int = 1
var current_experience: int = 0

func _init():
	Events.grant_experience.connect(add_experience)

func add_experience(amount: int) -> void:
	current_experience += amount
	while LEVEL_UP_REQUIREMENTS.has(level) && current_experience >= LEVEL_UP_REQUIREMENTS[level]:
		current_experience -= LEVEL_UP_REQUIREMENTS[level]
		level += 1

func get_required_exp_for_next_level():
	return LEVEL_UP_REQUIREMENTS[level]
