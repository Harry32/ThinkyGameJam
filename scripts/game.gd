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


func change_level(level: String):
	if get_child_count() > 1:
		get_child(1).queue_free()
	add_child(load(level).instantiate())
