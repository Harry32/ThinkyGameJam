extends StaticBody2D

## Set here the door that should be opened
@export var door : StaticBody2D
var pressedColor : Color = Color("#88ba55")
var notPressedColor : Color = Color("#fa7e71")

## Opens the door when a box hit the button
func _on_area_2d_body_entered(body):
	if body is RigidBody2D and body.name == "Box":
		$ColorRect2.color = pressedColor
		door.open()


## Closes the door when a box hit the button
func _on_area_2d_body_exited(body):
	if body is RigidBody2D and body.name == "Box":
		$ColorRect2.color = notPressedColor
		door.close()
