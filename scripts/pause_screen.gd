extends CanvasLayer


func _ready():
	visible = false


func _on_restart_button_pressed():
	LevelsInformation.restart_level()


func _on_skip_button_pressed():
	LevelsInformation.next_level()


func _on_main_screen_pressed():
	LevelsInformation.start_screen()


func _on_visibility_changed():
	if visible:
		get_tree().paused = true
	else:
		get_tree().paused = false
