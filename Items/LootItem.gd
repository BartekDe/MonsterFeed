extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label

@export var item: Item = null

var is_mouse_hover = false

func is_empty():
	return item == null
	
func _ready():
	sprite.texture = item.texture
	label.text = item.name

func _process(delta):
	if self.is_mouse_hover && Input.is_action_just_pressed("left_click"):
		Events.item_picked_up.emit(item)
		queue_free()

func _on_mouse_entered():
	self.is_mouse_hover = true

func _on_mouse_exited():
	self.is_mouse_hover = false
