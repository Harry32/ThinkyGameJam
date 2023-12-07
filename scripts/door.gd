extends StaticBody2D

func _ready():
	$DoorAnimatedSprite.set_animation("Close")
	$DoorAnimatedSprite.frame = 11


func open():
	if $DoorAnimatedSprite.animation != "Open":
		var progress = 11 - $DoorAnimatedSprite.frame
		$DoorAnimatedSprite.set_animation("Open")
		$DoorAnimatedSprite.frame = progress
		$DoorCollisionShape.set_deferred("disabled", true)
		$DoorAnimatedSprite.play()


func close():
	if $DoorAnimatedSprite.animation != "Close":
		var progress = 11 - $DoorAnimatedSprite.frame
		$DoorAnimatedSprite.set_animation("Close")
		$DoorAnimatedSprite.frame = progress
		$DoorCollisionShape.set_deferred("disabled", false)
		$DoorAnimatedSprite.play()
