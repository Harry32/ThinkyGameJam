@tool
extends Node

var pressTime: int = 0
static var debugMode: bool = true


#func _process(delta):
	#if Input.is_key_pressed(KEY_F4):
		#var currentPressTime = Time.get_ticks_msec()
		#if currentPressTime - pressTime > 300:
			#pressTime = currentPressTime
			##game_information.debugMode = not game_information.debugMode
			##var status = "ON" if game_information.is_debug_mode() else "OFF"
			#debugMode = not debugMode
			#var status = "ON" if debugMode else "OFF"
			#push_warning("Debug Mode is %s" % status)
