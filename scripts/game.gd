extends Node

func _input(event):
	if event.is_action_pressed("Pause"):
		var current_status = get_tree().paused
		get_tree().paused = not current_status
		if not current_status:
			$PauseOverlay.show()
		else:
			$PauseOverlay.hide()
