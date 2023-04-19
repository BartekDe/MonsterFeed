extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

@onready var timer: Timer = $Timer

var is_hurt_animation_on_cooldown = false

func _on_area_entered(area):
	if !self.is_hurt_animation_on_cooldown:
		var hit_effect = HitEffect.instantiate()
		var main = get_tree().current_scene
		main.add_child(hit_effect)
		hit_effect.global_position = global_position
		self.is_hurt_animation_on_cooldown = true
		timer.start(.5)

func _on_timer_timeout():
	self.is_hurt_animation_on_cooldown = false
