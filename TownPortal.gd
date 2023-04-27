extends Area2D

var town_scene = preload("res://Scenes/TownScene.tscn")
var is_player_in_portal = false
@onready var enter_town_label = $EnterTownLabel

func _process(delta):
	if is_player_in_portal && Input.is_action_just_pressed("enter_town"):
		Events.switch_scene.emit("res://Scenes/TownScene.tscn")

func _on_body_entered(body: PhysicsBody2D):
	if body.is_in_group("Player"):
		enter_town_label.visible = true
		is_player_in_portal = true


func _on_body_exited(body):
	if body.is_in_group("Player"):
		enter_town_label.visible = false
		is_player_in_portal = false
