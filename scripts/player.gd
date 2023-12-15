extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = 600.0
const PUSH_FORCE = 60.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * -1
var block_deceleration: bool = false
var external_gravity: bool = false
var currentAngle: float = 0
var state: String = "Idle"
var animation_playback: AnimationNodeStateMachinePlayback
var direction: float = 0
var active: bool = true


func _ready():
	GravityInformation.connect("up_direction_change", update_up_direction)
	animation_playback = $AnimationTree["parameters/playback"]
	$AnimationTree.active = true
	$PlayerSprite.material.set_shader_parameter("progress", 0)

	if GameInformation.is_debug_mode():
		active = true
	else:
		active = false
		teleport(false)


func _process(_delta):
	update_animation()


func _physics_process(delta):
	if not is_on_floor():
		calculate_gravity(delta)

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()

	if Input.is_action_pressed("Gravity") and active:
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
		state = "Jump"


## Change direction based on input.
func change_up_direction():
	state = "A.Power"
	# I changed the order of these parameters to avoid calculations
	var newUpDirection = Input.get_vector("Right", "Left", "Down", "Up")
	if newUpDirection != Vector2.ZERO and newUpDirection != GravityInformation.get_up_direction():
		if abs(newUpDirection.x) != abs(newUpDirection.y):
			GravityInformation.update_up_direction(newUpDirection)


## Handle character movement.
func movement():
	if active:
		# Get the input direction and handle the movement/deceleration
		direction = Input.get_axis("Left", "Right")
		var direction_vertical_movement = 1

		if up_direction.y != 0:
			if direction:
				velocity.x = direction * SPEED
			else:
				if not block_deceleration:
					velocity.x = move_toward(velocity.x, 0, SPEED)
		else:
			if up_direction == Vector2.LEFT:
				direction_vertical_movement = -1
			else:
				direction_vertical_movement = 1

			if direction:
				velocity.y = direction * direction_vertical_movement * SPEED
			else:
				if not block_deceleration:
					velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)


## Calculate push force on RigidBody2d objects that the player collide with
func calculate_push():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * PUSH_FORCE)


## Toggle external gravity flag
func toggle_external_gravity():
	block_deceleration = not block_deceleration


## Simulate RigidBody2d apply_central_impulse function
func apply_central_impulse(impulse: Vector2):
	velocity += impulse


## Rotate the player to keep the head up
func rotate_player(newUpDirection: Vector2):
	var angle = $TopRayCast.target_position.angle_to(newUpDirection)
	if angle != currentAngle:
		currentAngle = angle
		$CollisionShape2D.scale = Vector2(0.3, 0.3)
		
		var tween = create_tween().parallel()
		tween.tween_property(self, "rotation", angle, 0.3)
		var tween2 = create_tween().parallel()
		tween2.tween_property($CollisionShape2D, "scale", Vector2(1, 1), 0.3)


## Update up direction if the gravity is no changed by externals origins
func update_up_direction(upDirection: Vector2):
	if not external_gravity:
		set_up_direction(upDirection)
		rotate_player(upDirection)


## Update direction and mark as external gravity
func set_external_gravity(upDirection: Vector2):
	update_up_direction(upDirection)
	external_gravity = true


## Mark as global gravity and update direction
func set_global_gravity():
	external_gravity = false
	update_up_direction(GravityInformation.get_up_direction())


func update_animation():
	update_facing_direction()
	
	if active:
		if is_on_floor():
			if state == "Idle":
				$AnimationTree.set("parameters/Move/blend_position", direction)

			if state == "Fall" and ((GravityInformation.get_up_direction().y != 0 and velocity.y == 0) or (GravityInformation.get_up_direction().x != 0 and velocity.x == 0)):
				state = "Landing"

			if state == "Landing":
				state = "Idle"
				animation_playback.travel("Landing")

		else:
			if state == "Idle" and animation_playback.get_current_node() == "Move":
				state = "Fall"
				animation_playback.travel("Fall")
			if state == "Fall":
				animation_playback.travel("Fall")
			if state == "Jump" and animation_playback.get_current_node() != "Jump":
				animation_playback.travel("Jump")
			if state == "Jump":
				if (GravityInformation.get_up_direction().y < 0 and velocity.y > 0) or (GravityInformation.get_up_direction().y > 0 and velocity.y < 0) or (GravityInformation.get_up_direction().x < 0 and velocity.x > 0) or (GravityInformation.get_up_direction().x > 0 and velocity.x < 0):
					state = "Fall"
					animation_playback.travel("Fall")

		if state == "A.Power":
			state = "H.Power"
			animation_playback.travel("Activating Power")

		if state == "H.Power":
			animation_playback.travel("Holding Power")

		if (state == "D.Power" or state == "H.Power" or state == "A.Power") and not Input.is_action_pressed("Gravity"):
			state = "Fall"
			if is_on_floor():
				state = "Idle"
			animation_playback.travel("Deactivating Power")
	else:
		$AnimationTree.set("parameters/Move/blend_position", 0)


func update_facing_direction():
	if direction != 0:
		var upDirection: Vector2 = GravityInformation.get_up_direction()
		
		if external_gravity:
			upDirection = up_direction

		if upDirection != Vector2.DOWN:
			$PlayerSprite.flip_h = direction < 0
		else:
			$PlayerSprite.flip_h = direction > 0


func move_to(movement_position: Vector2):
	deactivate()

	if GravityInformation.get_up_direction().x == 0:
		position.x = move_toward(position.x, movement_position.x, SPEED)

	if GravityInformation.get_up_direction().y == 0:
		position.y = move_toward(position.y, movement_position.y, SPEED)


func deactivate():
	active = false


func activate():
	active = true


func teleport(leaving: bool = true):
	if GameInformation.is_debug_mode():
		next_level()
	else:
		var tween = create_tween()
		if leaving:
			tween.tween_method(set_shader_progress, 0.0, 0.5, 2)
			tween.connect("finished", next_level)
		else:
			tween.tween_method(set_shader_progress, 1.0, 0.0, 2)
			tween.connect("finished", activate)
			await get_tree().create_timer(1.2).timeout
		$TeleportSound.play()


func set_shader_progress(progress: float):
	$PlayerSprite.material.set_shader_parameter("progress", progress)


func next_level():
	LevelsInformation.next_level()
