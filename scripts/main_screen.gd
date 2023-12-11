extends Control

var options_screen = preload("res://scenes/options_screen/options_screen.tscn")
@onready var start_button = $MarginContainer/Controls/StartButton

signal main_screen_events(scene: PackedScene)

func _ready():
	start_button.grab_focus()


func _on_start_button_pressed():
	pass


func _on_options_button_pressed():
	main_screen_events.emit(options_screen)


func _on_quit_button_pressed():
	get_tree().quit()
