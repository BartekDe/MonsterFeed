extends GridContainer

var inventory: Resource = preload("res://Items/Inventory.tres")

func _ready():
	inventory.items_changed.connect(on_items_changed)
	update_inventory_display()
	
func on_items_changed(indexes: Array):
	for item_index in indexes:
		update_inventory_slot_display(item_index)
		
func update_inventory_slot_display(index: int):
	var inventorySlotDisplay: Node = get_child(index)
	var item: Item = inventory.items[index]
	inventorySlotDisplay.display_item(item, index)
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)
