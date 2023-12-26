extends State


@onready var groundState = $"../Ground"
@onready var fallState = $"../Fall"


func enter():
	animationPlayback.travel("Deactivating Power")
	if targetCharacter.is_on_floor():
		exit(groundState)
	else:
		exit(fallState)
