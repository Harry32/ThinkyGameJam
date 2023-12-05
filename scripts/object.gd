extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * -1
var gravity_vector: Vector2 = Vector2(0, 0)


func _ready():
	GravityInformation.connect("up_direction_change", change_up_direction)
	
	gravity_vector.y = -gravity * mass
	gravity_scale = 0


func _physics_process(_delta):
	apply_central_force(gravity_vector)


## Change gravity direction upon signal
func change_up_direction(upDirection: Vector2):
	gravity_vector = gravity * mass * upDirection
