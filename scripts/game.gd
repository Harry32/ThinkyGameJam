extends Node


func _ready():
	LevelsInformation.connect("change_scene", change_scene)
	LevelsInformation.start_screen()


func _input(event):
	if LevelsInformation.enable_ui() and event.is_action_pressed("Pause"):
		if not get_tree().paused:
			$PauseScreen.show()
		else:
			$PauseScreen.hide()
			
	if LevelsInformation.enable_ui() and event.is_action_pressed("Restart"):
		LevelsInformation.restart_level()


func change_scene(scene: String, showInstructions: bool, music: String):
	$PauseScreen.hide()
	if get_child_count() > 3:
		get_child(3).queue_free()
	call_deferred("add_child", load(scene).instantiate())

	if showInstructions:
		$Instruction.show()
	else:
		$Instruction.hide()

	if $AudioStreamPlayer.stream.resource_path != music:
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.stream = load(music)
		$AudioStreamPlayer.play()
