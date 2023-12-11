class_name main_screen
extends Control

@onready var start_button = $MarginContainer/controls/start_button as Button
@onready var quit_button = $MarginContainer/controls/quit_button as Button
@onready var options_button = $MarginContainer/controls/options_button as Button

@onready var options_menu = $options_screen as options_screen
@onready var mar_cont = $MarginContainer as MarginContainer

@onready var start_level = preload("res://scenes/levels/level.tscn") as PackedScene


func _ready():
	connecting_signals()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_options_pressed() -> void:
	mar_cont.visible = false
	options_menu.visible = true

func on_quit_pressed() -> void:
	get_tree().quit()

func on_exit_options_screen() -> void:
	pass

func connecting_signals() -> void:
	start_button.grab_focus()
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	quit_button.button_down.connect(on_quit_pressed)
	options_menu.exit_options_screen.connect(on_exit_options_screen)
