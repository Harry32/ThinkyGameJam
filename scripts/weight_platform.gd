extends StaticBody2D

## Set the necessary weight to move the platform. The weight used is the mass of the rigid body that interacts with the platform
@export var necessaryWeigth : float = 3
## Set the distance the platform will travel
@export var movementDistance : float = 200
## Set the platform's speed
@export var speed : float = 300
## Set the platform's start position
@export var startDown : bool = false

var currentWeight : float = 0;
var originalPosition : Vector2
var destinationPosition : Vector2
var movementPosition: Vector2

var tween: Tween


func _ready():
	originalPosition = position
	destinationPosition = Vector2(originalPosition.x, originalPosition.y + movementDistance)
	movementPosition = position

	update_label(false)

	if startDown:
		position = destinationPosition
		movementPosition = destinationPosition


func _physics_process(_delta):
	position = position.lerp(movementPosition, 1)


## At every new RigidBody2D on the platform the currentWeight is updated
func _on_area_2d_body_entered(body):
	var preWeight = currentWeight
	if body is RigidBody2D:
		currentWeight += body.mass

		update_label()

		if preWeight < necessaryWeigth and currentWeight >= necessaryWeigth:
			if position != destinationPosition:
				move_platform(destinationPosition)
				play_animation(false)


## At every new RigidBody2D that leaves the platform the currentWeight is updated
func _on_area_2d_body_exited(body):
	var preWeight = currentWeight
	if body is RigidBody2D:
		currentWeight -= body.mass

		update_label()

		if preWeight >= necessaryWeigth and currentWeight < necessaryWeigth:
			if position != originalPosition:
				move_platform(originalPosition)
				play_animation(true)


## A tween is setted to gradually change destinationPosition
func move_platform(destination: Vector2):
	var duration = int(destination.length() / float(speed * ($AnimatedSprite.scale.y/2)))

	if tween != null:
		tween.kill()

	tween = get_tree().create_tween()
	tween.tween_property(self, "movementPosition", destination, duration)
	tween.connect("finished", stop_animation)


## Update label color and text
func update_label(blinkText: bool = true):
	var value = necessaryWeigth - currentWeight

	$Monitor.set_text(str(value), blinkText)


func play_animation(up: bool):
	if up:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.play_backwards()


func stop_animation():
	$AnimatedSprite.stop()
