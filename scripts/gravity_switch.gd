extends StaticBody2D

## Set here the door that should be opened
@export var door : StaticBody2D

var onColor: Color = Color("#94dc58")
var offColor: Color = Color("#ff6f70")
var lightsArray: Array[PointLight2D] = []


func _ready():
	lightsArray.append_array($OnLights.get_children())
	lightsArray.append_array($OffLights.get_children())


func _on_on_area_body_entered(_body):
	turn_lights_on("OnLights")
	door.open()


func _on_off_area_body_entered(_body):
	turn_lights_on("OffLights")
	door.close()


## Turns on the designated lights
func turn_lights_on(lights: String):
	for light in lightsArray:
		if  light.get_parent().name == lights:
			light.enabled = true
		else:
			light.enabled = false
