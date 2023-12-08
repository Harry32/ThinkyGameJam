extends BlackHole


## Set here with the sibling wormhole
@export var sibling: Area2D

var destinationPosition: Vector2
var active: bool = true
var transitionBodies: Array[Node2D]


func _ready():
	destinationPosition = sibling.position


## Set new position and add the body in the sibling's transition array
func _on_wormwhole_area_body_entered(body):
	if body not in transitionBodies:
		if body is RigidBody2D:
			body.teleportPosition = destinationPosition
		else:
			body.position = destinationPosition
		sibling.transitionBodies.append(body)


## Remove the body from the transition array
func _on_wormwhole_area_body_exited(body):
	transitionBodies.erase(body)
