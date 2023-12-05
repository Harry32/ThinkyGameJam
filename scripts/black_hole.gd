extends Area2D

## Set the force of the black hole's gravity field
@export_range(0, 500) var gravityForce : float = 40

var affectedBodies = []


## Apply impulses to every object in the field
func _physics_process(_delta):
	for i in affectedBodies.size():
		var direction = (position - affectedBodies[i].position).normalized()
		affectedBodies[i].apply_central_impulse(direction * gravityForce)


## Add object to array
func _on_body_entered(body):
	if not body is StaticBody2D:
		affectedBodies.append(body)
		if body.name == "Player":
			body.toggle_external_gravity()


## Remove object to array
func _on_body_exited(body):
	if not body is StaticBody2D:
		affectedBodies.erase(body)
		if body.name == "Player":
			body.toggle_external_gravity()
