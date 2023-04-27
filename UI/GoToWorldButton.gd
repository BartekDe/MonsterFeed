extends Button

func _on_pressed():
	Events.switch_scene.emit("res://Scenes/World.tscn")
