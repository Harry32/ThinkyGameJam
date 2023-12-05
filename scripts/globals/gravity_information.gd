extends Node

signal up_direction_change(upDirection: Vector2)

var upDirection : Vector2 = Vector2.UP


func update_up_direction(newUpDirection: Vector2):
	upDirection = newUpDirection
	up_direction_change.emit(upDirection)
