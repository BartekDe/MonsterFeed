extends Resource

class_name Inventory

signal items_changed(indexes)

@export var items: Array = [null, null, null, null, null, null]

func _init():
	Events.item_picked_up.connect(add_item_to_inventory)

func set_item(item_index, item):
	var previousItem = items[item_index]
	items[item_index] = item
	items_changed.emit([item_index])

	return previousItem
	
func swap_items(item_index, target_item_index):
	var targetItem = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = targetItem
	items_changed.emit([item_index, target_item_index])
	
func remove_item(item_index):
	var previousItem = items[item_index]
	items[item_index] = null
	items_changed.emit([item_index])

	return previousItem
	
func add_item_to_inventory(item: Item):
	var is_placed = false
	for item_index in items.size():
		if items[item_index] == null:
			set_item(item_index, item)
			is_placed = true
			break
	if !is_placed:
		Events.inventory_full.emit()
