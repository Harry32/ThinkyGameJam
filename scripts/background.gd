extends Node

var gasPlanetSpeed: float = 30

func _physics_process(delta):
	$Path2D/PathFollow2D.progress += gasPlanetSpeed * delta
