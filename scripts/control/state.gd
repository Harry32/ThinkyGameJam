extends Node
class_name State
## A generic state for the State Machine component.
##
## Create a state that inherit from this class to populate the state machine.


signal update_state(newState: State)


var targetCharacter: CharacterBody2D
var animationTree: AnimationTree
var animationPlayback: AnimationNodeStateMachinePlayback


## Set the state's main properties.
## [param character]: The target from the state machine
## [param tree]: The target's animation tree
func setup(character: CharacterBody2D, tree: AnimationTree):
	targetCharacter = character
	animationTree = tree
	animationPlayback = animationTree["parameters/playback"]


## Implement this method to define an entering behavior
func enter():
	pass


## Implement this method to define a different exiting behavior.
## [param nextState]: State to be transitioned to
func exit(nextState: State):
	update_state.emit(nextState)


## Implement this function to create control at each frame. See [method Node._process].
## [param delta]: Time in seconds since last frame
func state_process(_delta: float):
	pass


## Implement this function to create control at physics process. See [method Node._physics_process].
## [param delta]: Time in seconds since last call
func state_physics_process(_delta: float):
	pass


## Implement this function to create an input control. See [method Node._input]
## [param event]: Event trigged by Input
func state_input(_event: InputEvent):
	pass
