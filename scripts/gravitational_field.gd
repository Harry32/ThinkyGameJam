extends Area2D


var gravityValue = ProjectSettings.get_setting("physics/2d/default_gravity") * -1
var direction : Vector2


func _ready():
	var newDirection = $RayCast2D.target_position.rotated(rotation)

	direction.x = snapped(newDirection.x, 0.0001)
	direction.y = snapped(newDirection.y, 0.0001)

	$Particles.gravity = direction * gravityValue
	$Particles.emitting = true


func _on_body_entered(body):
	GravityInformation.update_up_direction(direction, body.name)


func _on_body_exited(body):
	GravityInformation.update_up_direction(direction, body.name, true)
