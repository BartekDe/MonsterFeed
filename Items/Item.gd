extends Resource

class_name Item

@export var name: String = ""
@export var texture: Texture

func use_item() -> bool:
	print("tried to use non-usable Item")
	return false
