extends State


@onready var landState = $"../Landing"
@onready var aPowerState = $"../APower"


func enter():
	animationPlayback.travel("Fall")


func state_physics_process(_delta: float):
	if targetCharacter.active:
		var up_direction = GravityInformation.get_up_direction(targetCharacter.name)
		var velocity = targetCharacter.velocity

		if targetCharacter.is_on_floor() and ((up_direction.y != 0 and velocity.y == 0) or (up_direction.x != 0 and velocity.x == 0)):
			exit(landState)

		if Input.is_action_pressed("Gravity"):
			var newUpDirection = Input.get_vector("Right", "Left", "Down", "Up")
			GravityInformation.update_up_direction(newUpDirection)
