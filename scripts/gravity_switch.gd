extends StaticBody2D

@export var door : StaticBody2D
var onColor : Color = Color("#94dc58")
var offColor : Color = Color("#ff6f70")


func _on_on_area_body_entered(body):
	#if body is RigidBody2D:
	$Box/LightL.color = onColor
	$Box/LightR.color = onColor
	door.open()


func _on_off_area_body_entered(body):
	#if body is RigidBody2D:
	$Box/LightL.color = offColor
	$Box/LightR.color = offColor
	door.close()
