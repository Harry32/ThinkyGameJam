extends StaticBody2D

## Number of hits required to break the cover
@export var hits_to_break: int = 3
## Minimum velocity required to register a hit
@export var min_velocity_to_break: float = 700
var current_hits: int
var animation_steps: Array[String] = ["Whole", "Hit 1", "Hit 2", "Broken"]
var animation_current_step: int = 0
var fragments_direction: Array[Vector2] = [Vector2(-1, 1)]


func _ready():
	$CoverAnimatedSprite.set_animation("Whole")
	
	if hits_to_break < 3:
		for i in range(0, 3 - hits_to_break):
			animation_steps.remove_at(1)

	for fragment in $Fragments.get_children():
		fragment.process_mode = Node.PROCESS_MODE_DISABLED


func _on_cover_hit_area_body_entered(body):
	if body is RigidBody2D and body.get_velocity() > min_velocity_to_break:
		current_hits += 1
		if current_hits == hits_to_break:
			$TopCollisionShape.queue_free()
			$GlassCollisionShape.queue_free()
			$CoverHitArea.queue_free()
			$CPUParticles2D.emitting = true
			activate_fragments()

			body.apply_central_impulse(position.direction_to(body.position) * body.get_velocity())
		play_hit_animation()


## Play the needed animation
func play_hit_animation():
	animation_current_step += 1
	$CoverAnimatedSprite.play(animation_steps[animation_current_step])


## Activate and prepare fragments
func activate_fragments():
	$Fragments.visible = true
	var direction = -1
	var additional_force = 200
	for fragment in $Fragments.get_children():
		fragment.process_mode = Node.PROCESS_MODE_INHERIT
		fragment.apply_central_impulse(Vector2(direction, -1) * (300 + additional_force))
		direction += 1

		if direction > 1:
			direction = -1
			additional_force -= 100
