extends Node

var debugMode: bool = false

var resolutions: Dictionary = {
	"1920 x 1440" : Vector2(1920, 1440),
	"1920 x 1080": Vector2(1920, 1080),
	"1440 x 900" : Vector2(1440, 900),
	"1280 x 720" : Vector2(1280, 720),
	"1280 x 1024" : Vector2(1280, 1024),
	"1024 x 768" : Vector2(1024, 768)
}

func is_debug_mode() -> bool:
	return debugMode


func get_resolutions() -> Dictionary:
	return resolutions

func set_resolution(key: String):
	get_window().size = resolutions[key]

func get_current_resolution() -> String:
	return "%d x %d" % [get_window().size.x, get_window().size.y]
