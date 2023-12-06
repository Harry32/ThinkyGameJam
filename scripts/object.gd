extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * -1
var gravity_vector: Vector2 = Vector2(0, 0)
var previous_velocity: float
var actual_velocity: float

func _ready():
	GravityInformation.connect("up_direction_change", change_up_direction)
	
	gravity_vector.y = -gravity * mass
	gravity_scale = 0

func _physics_process(_delta):
	apply_central_force(gravity_vector)
	
func _integrate_forces(state):
	previous_velocity = actual_velocity
	actual_velocity = state.linear_velocity.length()
	
func get_velocity():
	return abs(previous_velocity - actual_velocity)

## Change gravity direction upon signal
func change_up_direction(upDirection: Vector2):
	gravity_vector = gravity * mass * upDirection
