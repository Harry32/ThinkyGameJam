extends Node


func _ready():
	LevelsInformation.connect("change_level", change_level)
	LevelsInformation.start_game()


func _input(event):
	if event.is_action_pressed("Pause"):
		var current_status = get_tree().paused
		get_tree().paused = not current_status
		if not current_status:
			$PauseScreen.show()
		else:
			$PauseScreen.hide()
			
	if event.is_action_pressed("Restart"):
		LevelsInformation.restart_level()


func change_level(level: String):
	if get_child_count() > 1:
		get_child(1).queue_free()
	call_deferred("add_child", load(level).instantiate())
