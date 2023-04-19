extends Node2D

const lootItem: PackedScene = preload("res://Items/LootItem.tscn")

func _ready():
	Events.drop_loot.connect(place_loot_item)
	
func place_loot_item(item: Item, global_position: Vector2):
	var loot_item = lootItem.instantiate()
	loot_item.global_position = global_position
	loot_item.item = item
	add_child(loot_item)
