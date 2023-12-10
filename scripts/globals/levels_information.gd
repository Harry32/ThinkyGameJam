extends Node


signal change_level(nextLevel: String)


var levels : Array[String] = [
	"res://scenes/levels/tutorial.tscn",
	"res://scenes/levels/button_pres.tscn"
]
var current_level: int = 0

func next_level():
	if current_level < levels.size():
		current_level += 1
		change_level.emit(levels[current_level])


func previous_level():
	if current_level > 0:
		current_level -= 1
		change_level.emit(levels[current_level])


func start_game():
	current_level = 0
	change_level.emit(levels[current_level])
