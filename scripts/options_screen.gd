extends Control

var main_screen = "res://scenes/screens/main_screen.tscn"
@onready var exit_button = $MarginContainer/VBoxContainer/ExitButton


func _ready():
	exit_button.grab_focus()


func _on_exit_button_pressed():
	LevelsInformation.change_screen(main_screen)
