extends "res://scripts/object.gd"

func _on_area_2d_body_entered(_body):
	$HitSound.play()
