extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = 600.0
const PUSH_FORCE = 60.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * -1
var external_gravity : bool = false
var currentAngle : float = 0


func _physics_process(delta):
	if not is_on_floor():
		calculate_gravity(delta)

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()

	if Input.is_action_pressed("Gravity"):
		change_up_direction()
	else:
		movement()
	
	move_and_slide()
	calculate_push()


## Add the gravity based on up_direction vector.
func calculate_gravity(delta):
	velocity.y += gravity * (up_direction.y) * delta
	velocity.x += gravity * (up_direction.x) * delta


## Handle jump based on up_direction vector.
func jump():
		velocity.y = JUMP_VELOCITY * (up_direction.y)
		velocity.x = JUMP_VELOCITY * (up_direction.x)


## Change direction based on input.
func change_up_direction():
	# I changed the order of these parameters to avoid calculations
	var newUpDirection = Input.get_vector("Right", "Left", "Down", "Up")
	if newUpDirection != Vector2.ZERO and newUpDirection != GravityInformation.upDirection:
		set_up_direction(newUpDirection)
		rotate_player(newUpDirection)
		GravityInformation.update_up_direction(newUpDirection)


## Handle character movement.
func movement():
	# Get the input direction and handle the movement/deceleration
	var direction = Input.get_axis("Left", "Right")
	var direction_vertical_movement = 1
	
	if up_direction.y != 0:
		if direction:
			velocity.x = direction * SPEED
		else:
			if not external_gravity:
				velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		if up_direction == Vector2.LEFT:
			direction_vertical_movement = -1
		else:
			direction_vertical_movement = 1
			
		if direction:
			velocity.y = direction * direction_vertical_movement * SPEED
		else:
			if not external_gravity:
				velocity.y = move_toward(velocity.y, 0, SPEED)


## Calculate push force on RigidBody2d objects that the player collide with
func calculate_push():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * PUSH_FORCE)


## Toggle external gravity flag
func toggle_external_gravity():
	external_gravity = not external_gravity


## Simulate RigidBody2d apply_central_impulse function
func apply_central_impulse(impulse: Vector2):
	velocity += impulse


## Rotate the player to keep the head up
func rotate_player(newUpDirection: Vector2):
	var angle = $TopRayCast.target_position.angle_to(newUpDirection)
	var tween = create_tween()
	tween.tween_property(self, "rotation", angle, 0.3)
