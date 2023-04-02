extends Node2D

const INVENTORY_NAME = "loot_bag"

@onready var contents = $Contents
var is_mouse_hover = false

signal item_picked_up

func is_empty():
	return contents.get_children().is_empty()

func _process(delta):
	if self.is_mouse_hover && Input.is_action_just_pressed("left_click"):
		print("clicked lootbag")
		item_picked_up.emit(INVENTORY_NAME)
		# define behavior when loot bag is clicked - add one element to inventory

func _on_mouse_entered():
	self.is_mouse_hover = true

func _on_mouse_exited():
	self.is_mouse_hover = false
