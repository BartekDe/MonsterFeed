extends Node

@onready var coin_storage: CoinStorage = preload("res://Resources/CoinStorage.tres") as CoinStorage
var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func _init():
	Events.switch_scene.connect(switch_scene)
	
func switch_scene(path: String) -> void:
	call_deferred("_deferred_switch_scene", path)

func _deferred_switch_scene(path: String) -> void:
	current_scene.free()
	var scene = ResourceLoader.load(path)
	current_scene = scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
