extends Node


func _ready():
	var main_screen = preload("res://scenes/main_screen/main_screen.tscn")
	var instance = main_screen.instantiate()
	call_deferred("add_child", instance)
	instance.connect("main_screen_events", change_scene)


func change_scene(scene: PackedScene) -> void:
	if get_child_count() > 0:
		get_child(0).queue_free()
	var instance = scene.instantiate()
	call_deferred("add_child", instance)
	instance.connect("options_screen_events", change_scene)
