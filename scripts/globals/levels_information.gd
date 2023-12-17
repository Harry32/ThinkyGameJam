extends Node


signal change_scene(scene: String)


var levels : Array[String] = [
	"res://scenes/levels/tutorial.tscn",
	"res://scenes/levels/ref_gravity.tscn",
	"res://scenes/levels/pres_platform.tscn",
	"res://scenes/levels/ref_platform.tscn",
	"res://scenes/levels/pres_switch.tscn",
	"res://scenes/levels/ref_switch.tscn",
	"res://scenes/levels/pres_button.tscn",
	"res://scenes/levels/ref_button.tscn",
	"res://scenes/levels/pres_cover.tscn",
	"res://scenes/levels/ref_cover.tscn",
	"res://scenes/levels/pres_wormhole.tscn",
	"res://scenes/levels/ref_wormwhole.tscn"
]

var main_screen: String = "res://scenes/screens/main_screen.tscn"
var credit_screen: String = "res://scenes/screens/credits_screen.tscn"
var current_scene: String
var current_level: int = 0


func next_level():
	if current_level < levels.size() -1:
		current_level += 1
		current_scene = levels[current_level]
		change_scene.emit(levels[current_level])
	else:
		credits_screen()


func previous_level():
	if current_level > 0:
		current_level -= 1
		current_scene = levels[current_level]
		change_scene.emit(levels[current_level])


func start_game():
	current_level = 0
	current_scene = levels[current_level]
	change_scene.emit(current_scene)


func start_screen():
	current_scene = main_screen
	change_scene.emit(main_screen)


func credits_screen():
	current_scene = credit_screen
	change_scene.emit(credit_screen)


func restart_level():
	change_scene.emit(current_scene)


func change_screen(scene: String):
	current_scene = scene
	change_scene.emit(scene)


func enable_ui():
	return current_scene.contains("levels")
