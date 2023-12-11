extends Control

var main_screen = preload("res://scenes/main_screen/main_screen.tscn")
@onready var exit_button = $MarginContainer/VBoxContainer/ExitButton

signal options_screen_events(scene: PackedScene)

func _ready():
	exit_button.grab_focus()


func _on_exit_button_pressed():
	options_screen_events.emit(main_screen)
