extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * -1
var gravity_vector: Vector2 = Vector2(0, 0)
var previous_velocity: float
var actual_velocity: float
var external_gravity: bool = false


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


## Update up direction if the gravity is no changed by externals origins
func change_up_direction(upDirection: Vector2):
	if not external_gravity:
		gravity_vector = gravity * mass * upDirection


## Update direction and mark as external gravity
func set_external_gravity(upDirection: Vector2):
	change_up_direction(upDirection)
	external_gravity = true


## Mark as global gravity and update direction
func set_global_gravity():
	external_gravity = false
	change_up_direction(GravityInformation.get_up_direction())
