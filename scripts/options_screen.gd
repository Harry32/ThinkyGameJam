class_name options_screen
extends Control

@onready var exit_button = $MarginContainer/VBoxContainer/exit_button as Button

signal exit_options_screen

func _ready():
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	exit_options_screen.emit()
	set_process(false)
