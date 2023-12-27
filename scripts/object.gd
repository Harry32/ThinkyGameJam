extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * -1
var gravity_vector: Vector2 = Vector2(0, 0)
var teleportPosition: Vector2
var previous_velocity: float
var actual_velocity: float


func _ready():
	GravityInformation.connect("up_direction_change", change_up_direction)

	gravity_vector.y = -gravity * mass
	gravity_scale = 0


func _physics_process(_delta):
	apply_central_force(gravity_vector)


func _integrate_forces(state):
	if teleportPosition != Vector2.ZERO:
		state.transform.origin = teleportPosition
		teleportPosition = Vector2.ZERO

	previous_velocity = actual_velocity
	actual_velocity = state.linear_velocity.length()


func get_velocity():
	return abs(previous_velocity)


## Update up direction if the gravity is no changed by externals origins
func change_up_direction(targetName: String):
	if targetName == "" or targetName == self.name:
		var upDirection = GravityInformation.get_up_direction(self.name)

		gravity_vector = gravity * mass * upDirection


func _on_area_2d_body_entered(_body):
	$HitSound.play()
