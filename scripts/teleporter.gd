extends StaticBody2D


var leftOccluderClosePosition: Vector2
var rightOccluderClosePosition: Vector2
var leftOccluderOpenPosition: Vector2
var rightOccluderOpenPosition: Vector2
var isTurnedOn: bool = false
var player: CharacterBody2D
var upDirection: Vector2
var tweenL: Tween
var tweenR: Tween
var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	leftOccluderOpenPosition = Vector2($LeftLightOccluder.position.x - 36, $LeftLightOccluder.position.y)
	rightOccluderOpenPosition = Vector2($RightLightOccluder.position.x + 36, $RightLightOccluder.position.y)
	leftOccluderClosePosition = $LeftLightOccluder.position
	rightOccluderClosePosition = $RightLightOccluder.position
	$BackPointLight.enabled = false
	$FrontPointLight.enabled = false

	var newDirection = $RayCast2D.target_position.rotated(rotation)
	upDirection = Vector2(snapped(newDirection.x, 0.0001), snapped(newDirection.y, 0.0001))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not $BackPointLight.enabled and isTurnedOn:
		$BackPointLight.enabled = true
		$FrontPointLight.enabled = true

	if $BackPointLight.enabled and not isTurnedOn and $RightLightOccluder.position == rightOccluderClosePosition:
		$BackPointLight.enabled = false
		$FrontPointLight.enabled = false


func _on_area_2d_body_entered(_body):
	toggle_teleporter(leftOccluderOpenPosition, rightOccluderOpenPosition)
	isTurnedOn = true
	


func _on_area_2d_body_exited(_body):
	toggle_teleporter(leftOccluderClosePosition, rightOccluderClosePosition)
	isTurnedOn = false


func toggle_teleporter(leftOccluderPosition: Vector2, rightOccluderPosition: Vector2):
	if tweenR != null:
		tweenR.kill()

	if tweenL != null:
		tweenL.kill()

	tweenR = create_tween().parallel()
	tweenR.tween_property($RightLightOccluder, "position", rightOccluderPosition, 2)
	tweenL = create_tween().parallel()
	tweenL.tween_property($LeftLightOccluder, "position", leftOccluderPosition, 2)


func _on_teleport_area_body_entered(body):
	player = body

	if GravityInformation.get_up_direction() != upDirection:
		GravityInformation.update_up_direction(upDirection)

	player.move_to(position)

	if GameInformation.is_debug_mode():
		activate_teleport()
	else:
		if tween != null:
			tween.kill()
		
		tween = create_tween().parallel()
		tween.tween_property($FrontPointLight, "energy", 5, 2)
		tween.connect("finished", activate_teleport)
		$EffectSound.play()


func activate_teleport():
	player.teleport()


func _on_tree_exiting():
	if tween != null:
		tween.kill()

	if tweenR != null:
		tweenR.kill()

	if tweenL != null:
		tweenL.kill()

	$EffectSound.stop()
