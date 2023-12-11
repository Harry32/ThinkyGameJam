extends Node


func _ready():
	LevelsInformation.connect("change_scene", change_scene)
	LevelsInformation.start_screen()


func _input(event):
	if LevelsInformation.enable_ui() and event.is_action_pressed("Pause"):
		var current_status = get_tree().paused
		get_tree().paused = not current_status
		if not current_status:
			$PauseScreen.show()
		else:
			$PauseScreen.hide()
			
	if LevelsInformation.enable_ui() and event.is_action_pressed("Restart"):
		LevelsInformation.restart_level()


func change_scene(scene: String):
	if get_child_count() > 1:
		get_child(1).queue_free()
	call_deferred("add_child", load(scene).instantiate())
