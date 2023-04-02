extends CanvasLayer

@onready var inventoryContainer: ColorRect = $InventoryContainer

func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if inventoryContainer.visible:
			inventoryContainer.visible = false
		else:
			inventoryContainer.visible = true
