extends "res://scripts/object.gd"

func _on_area_2d_body_entered(body):
	$HitSound.play()
