@tool
extends Node2D

@export var height: int = 1
var regionSize: float = 32


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	$LeftSprite.region_rect = Rect2(0, 0, regionSize, regionSize * height)
	$LeftSprite.position = Vector2(-regionSize, regionSize * (height - 1))
	$RightSprite.region_rect = Rect2(0, 0, regionSize, regionSize * height)
	$RightSprite.position = Vector2(regionSize, regionSize * (height - 1))
	#if scale.y > currentScale:
		
