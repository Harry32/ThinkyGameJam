extends Node
class_name StateMachine
## Main control for the state machine.
##
## Each function is responsible to keep the current state working.
## Each state must be a child node that inherit from [class State].


@export var character: CharacterBody2D
@export var animationTree: AnimationTree
@export var currentState: State


func _ready():
	var hasStates = false
	
	# Setup states
	for child in get_children():
		if child is State:
			child.setup(character, animationTree)
			child.connect("update_state", switch_states)
			hasStates = true

	if not hasStates:
		push_error("There are no states assigned to the " + character.name + " state machine!")


func _process(delta):
	currentState.state_process(delta)


func _physics_process(delta):
	currentState.state_physics_process(delta)


func _input(event):
	currentState.state_input(event)


## Receive states signals when a state should change
## [param newState] New current state
func switch_states(newState: State):
	currentState = newState
	currentState.enter()
