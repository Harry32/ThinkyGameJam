extends StaticBody2D

## Set here the door that should be opened
@export var door: StaticBody2D

var pressedColor: Color = Color("#88ba55")
var notPressedColor: Color = Color("#fa7e71")
var colliderStartPosition: Vector2
var colliderEndPosition: Vector2

func _ready():
	colliderStartPosition = $ButtonCollisionShape.position
	colliderEndPosition = Vector2(colliderStartPosition.x, colliderStartPosition.y + 10)


## Opens the door when a box hit the button
func _on_area_2d_body_entered(body):
	if body is RigidBody2D and body.name == "Box":
		$ButtonAnimatedSprite.play()
		var tween = create_tween()
		tween.tween_property($ButtonCollisionShape, "position", colliderEndPosition, 0.5)
		$PressSound.play()
		door.open()


## Closes the door when a box hit the button
func _on_area_2d_body_exited(body):
	if body is RigidBody2D and body.name == "Box":
		$ButtonAnimatedSprite.play_backwards()
		var tween = create_tween()
		tween.tween_property($ButtonCollisionShape, "position", colliderStartPosition, 1)
		$PressSound.play()
		door.close()
