extends Control

var options_screen = "res://scenes/screens/options_screen.tscn"
var credits_screen = "res://scenes/screens/credits_screen.tscn"

@onready var start_button = $MarginContainer/Controls/StartButton


func _ready():
	start_button.grab_focus()


func _on_start_button_pressed():
	LevelsInformation.start_game()


func _on_options_button_pressed():
	LevelsInformation.change_screen(options_screen)


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	LevelsInformation.change_screen(credits_screen)
