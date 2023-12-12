extends Control

var main_screen = "res://scenes/screens/main_screen.tscn"
@onready var exit_button = $MarginContainer/VBoxContainer/ExitButton
@onready var option_button = $MarginContainer/VBoxContainer/HBoxContainer/OptionButton


func _ready():
	exit_button.grab_focus()
	
	var currentResolution = GameInformation.get_current_resolution()
	var i = 0
	
	for item in GameInformation.get_resolutions():
		option_button.add_item(item)
		if item == currentResolution:
			option_button.select(i)
		i += 1


func _on_exit_button_pressed():
	LevelsInformation.change_screen(main_screen)


func _on_option_button_item_selected(index):
	GameInformation.set_resolution(option_button.get_item_text(index))
