extends Node

signal up_direction_change(upDirection: Vector2)

var upDirection : Vector2 = Vector2.UP
var localUpDirection : Vector2 = Vector2.ZERO


func update_up_direction(newUpDirection: Vector2) -> bool:
	var updated = false

	if newUpDirection != Vector2.ZERO and newUpDirection != upDirection:
		if abs(newUpDirection.x) != abs(newUpDirection.y):
			upDirection = newUpDirection
			up_direction_change.emit(upDirection)
			updated = true

	return updated


func update_local_up_direction(newUpDirection: Vector2):
	localUpDirection = newUpDirection
	up_direction_change.emit(localUpDirection)


func restore_global_up_direction():
	localUpDirection = Vector2.ZERO
	up_direction_change.emit(upDirection)


func get_up_direction():
	if localUpDirection != Vector2.ZERO:
		return localUpDirection
	return upDirection
