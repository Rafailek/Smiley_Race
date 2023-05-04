extends Button

@onready var level_selector = get_node("../LevelSelector")

var level1 = "res://level1.tscn"
var level2 = "res://level2.tscn"

func _on_pressed():
	if level_selector.get_selected() == 1:
		get_tree().change_scene_to_file(level1)
	if level_selector.get_selected() == 2:
		get_tree().change_scene_to_file(level2)
