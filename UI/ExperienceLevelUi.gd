extends Control

@onready var exp_bar: ColorRect = $ExpBar
@onready var exp_bar_bg: ColorRect = $ExpBarBackground
@onready var level_label: Label = $LevelLabel
@onready var exp_label: Label = $ExpLabel

var experience_level: ExperienceLevel = preload("res://Player/ExperienceLevel.tres")

var max_bar_length = 100

func _ready():
	max_bar_length = exp_bar_bg.size.x

func _process(delta):
	var bar_length = experience_level.get_required_exp_for_next_level()
	exp_bar.size.x = experience_level.current_experience * max_bar_length / bar_length if bar_length > 0 else max_bar_length
	level_label.text = "LVL:" + str(experience_level.level)
	exp_label.text = "EXP:" + str(experience_level.current_experience)
