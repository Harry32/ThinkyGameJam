extends State


@onready var groundState: State = $"../Ground"


func enter():
	animationPlayback.travel("Landing")
	exit(groundState)
