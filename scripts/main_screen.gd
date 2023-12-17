extends Control

@onready var start_button = $MarginContainer/Controls/StartButton


func _ready():
	start_button.grab_focus()


func _on_start_button_pressed():
	LevelsInformation.start_game()


func _on_options_button_pressed():
	LevelsInformation.options_screen()


func _on_quit_button_pressed():
	#get_tree().quit()
	pass


func _on_credits_button_pressed():
	LevelsInformation.credits_screen()
