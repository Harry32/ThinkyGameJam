extends State


@onready var fallState: State = $"../Fall"
@onready var aPowerState = $"../APower"


func enter():
	animationPlayback.travel("Jump")


func state_physics_process(_delta: float):
	if targetCharacter.active:
		var up_direction = GravityInformation.get_up_direction()
		var velocity = targetCharacter.velocity

		if (up_direction.y < 0 and velocity.y > 0) or (up_direction.y > 0 and velocity.y < 0) or (up_direction.x < 0 and velocity.x > 0) or (up_direction.x > 0 and velocity.x < 0):
			exit(fallState)
		
		if Input.is_action_pressed("Gravity"):
			var newUpDirection = Input.get_vector("Right", "Left", "Down", "Up")
			GravityInformation.update_up_direction(newUpDirection)
