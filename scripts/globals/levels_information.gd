extends Node


signal change_level(nextLevel: String)


var levels : Array[String] = [
	"res://scenes/levels/tutorial.tscn",
	"res://scenes/levels/ref_gravity.tscn",
	"res://scenes/levels/pres_platform.tscn",
	"res://scenes/levels/ref_platform.tscn",
	"res://scenes/levels/pres_switch.tscn",
	"res://scenes/levels/ref_switch.tscn",
	"res://scenes/levels/pres_button.tscn",
	"res://scenes/levels/ref_button.tscn",
	"res://scenes/levels/pres_field.tscn",
	"res://scenes/levels/ref_field.tscn",
	"res://scenes/levels/pres_cover.tscn",
	"res://scenes/levels/ref_cover.tscn",
	"res://scenes/levels/pres_wormhole.tscn",
	"res://scenes/levels/ref_wormwhole.tscn"
]
var current_level: int = 0

func next_level():
	if current_level < levels.size() -1:
		current_level += 1
		change_level.emit(levels[current_level])


func previous_level():
	if current_level > 0:
		current_level -= 1
		change_level.emit(levels[current_level])


func start_game():
	current_level = 0
	change_level.emit(levels[current_level])

func restart_level():
	change_level.emit(levels[current_level])
