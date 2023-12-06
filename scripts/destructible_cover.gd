extends StaticBody2D

## Number of hits required to break the cover
@export var hits_to_break: int = 3
## Minimum velocity required to register a hit
@export var min_velocity_to_break: float = 500.0
var current_hits: int

func _on_cover_hit_area_body_entered(body):
	if body is RigidBody2D and body.get_velocity() > min_velocity_to_break:
		current_hits += 1
	if current_hits == hits_to_break:
		queue_free()
