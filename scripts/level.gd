extends Node2D
class_name LevelBase


@export var initialGravity: Vector2


func _ready():
	if initialGravity != Vector2.ZERO:
		GravityInformation.update_up_direction(initialGravity * -1)
