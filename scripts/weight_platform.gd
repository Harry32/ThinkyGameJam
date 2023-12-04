extends AnimatableBody2D

## Set the necessary weight to move the platform. The weight used is the mass of the rigid body that interacts with the platform
@export var necessaryWeigth : float = 3
## Set the distance the platform will travel
@export var movementDistance : float = 200
## Set the platform's speed
@export var speed : float = 50

var currentWeight : float = 0;
var originalPosition : Vector2
var destinationPosition : Vector2
var tween : Tween
var activeColor : Color = Color("#88ba55")
var inactiveColor : Color = Color("#fa7e71")

func _ready():
	originalPosition = position
	destinationPosition = position
	tween = create_tween()
	update_label()


func _physics_process(delta):
	position = position.lerp(destinationPosition, 0.5 * delta)


## At every new RigidBody2D on the platform the currentWeight is updated
func _on_area_2d_body_entered(body):
	var preWeight = currentWeight
	if body is RigidBody2D:
		currentWeight += body.mass
		
		update_label()
		wait_time()
		
		if(preWeight < necessaryWeigth and currentWeight >= necessaryWeigth):
			move_platform(movementDistance)


## At every new RigidBody2D that leaves the platform the currentWeight is updated
func _on_area_2d_body_exited(body):
	var preWeight = currentWeight
	if body is RigidBody2D:
		currentWeight -= body.mass
		
		update_label()
		wait_time()
		
		if(preWeight >= necessaryWeigth and currentWeight < necessaryWeigth):
			move_platform(-movementDistance)


## A tween is setted to gradually change destinationPosition
func move_platform(distance: float):
	var move_position = Vector2(originalPosition.x, originalPosition.y + distance)
	
	var duration = move_position.length() / float(speed * ($PlatformContainer.size.y/2))
	
	if tween.is_running():
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(self, "destinationPosition", move_position, duration)


## Start and wait for a timer. It's used so bouncing box do not change the platform's movement
func wait_time():
	$Timer.start()
	await $Timer.timeout


## Update label color and text
func update_label():
	var value = necessaryWeigth - currentWeight
	
	$PlatformContainer/Label.text = str(value)
	
	if value == 0:
		$PlatformContainer/Label.add_theme_color_override("font_color", activeColor)
	else:
		$PlatformContainer/Label.add_theme_color_override("font_color", inactiveColor)
