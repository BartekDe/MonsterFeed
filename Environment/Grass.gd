extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func _on_hurtbox_area_entered(area):
	create_destroy_grass_effect()
	queue_free()

func create_destroy_grass_effect():
	var grass_destroy_effect = GrassEffect.instantiate()

	get_parent().add_child(grass_destroy_effect)
	grass_destroy_effect.position = self.position
