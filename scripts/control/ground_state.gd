extends State


@onready var jumpState: State = $"../Jump"
@onready var fallState = $"../Fall"
@onready var aPowerState = $"../APower"


func state_input(event: InputEvent):
	if targetCharacter.active:
		if targetCharacter.is_on_floor() and event.is_action_pressed("Jump"):
			jump()
			exit(jumpState)
		
		if event.is_action_pressed("Gravity"):
			exit(aPowerState)


func state_physics_process(_delta: float):
	if targetCharacter.active:
		animationTree.set("parameters/Move/blend_position", targetCharacter.direction)

		if not targetCharacter.is_on_floor():
			exit(fallState)
	else:
		animationTree.set("parameters/Move/blend_position", 0)


func jump():
	var upDirection = GravityInformation.get_up_direction(targetCharacter.name)

	targetCharacter.velocity.y = targetCharacter.JUMP_VELOCITY * (upDirection.y)
	targetCharacter.velocity.x = targetCharacter.JUMP_VELOCITY * (upDirection.x)
