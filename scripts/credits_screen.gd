extends Control


var main_screen = "res://scenes/screens/main_screen.tscn"


func _on_button_pressed():
	LevelsInformation.change_screen(main_screen)
