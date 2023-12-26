extends State


@onready var dPowerState = $"../DPower"


func enter():
	animationPlayback.travel("Holding Power")


func state_physics_process(_delta: float):
	if targetCharacter.active:
		var newUpDirection = Input.get_vector("Right", "Left", "Down", "Up")

		if GravityInformation.update_up_direction(newUpDirection):
			exit(dPowerState)


func state_input(event: InputEvent):
	if targetCharacter.active:
		if event.is_action_released("Gravity"):
			exit(dPowerState)
