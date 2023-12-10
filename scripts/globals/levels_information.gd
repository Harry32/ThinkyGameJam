extends Node

var levels : Array[String] = [
	"res://scenes/levels/tutorial.tscn",
	"res://scenes/levels/button_pres.tscn"
]
var current_level: int = 0

func next_level():
	if current_level < levels.size():
		current_level += 1
		get_tree().change_scene_to_file(levels[current_level])

func previous_level():
	if current_level > 0:
		current_level -= 1
		get_tree().change_scene_to_file(levels[current_level])


func start_game():
	current_level = 0
	get_tree().change_scene_to_file(levels[current_level])
