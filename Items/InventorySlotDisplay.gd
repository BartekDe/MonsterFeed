extends CenterContainer

class_name InventorySlotDisplay

var inventory: Inventory = preload("res://Items/Inventory.tres")

@onready var itemTextureRect: TextureRect = $ItemTextureRect

var is_mouse_hovering: bool = false
var own_index: int

func display_item(item: Item, index: int):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://UI/Inventory-slot16.png")
	own_index = index

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			try_using_item()

func try_using_item():
	var item = inventory.items[own_index]
	if item is Item:
		var was_used = item.use_item()
		if was_used:
			inventory.remove_item(own_index)
