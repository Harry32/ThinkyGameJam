extends Node2D


func _process(_delta):
	$ControllerTips.set_position($Player.position - Vector2(-60, 130))


func _on_checkpoint_1_body_entered(_body):
	$ControllerTips.show_jump()


func _on_checkpoint_2_body_entered(_body):
	$ControllerTips.show_gravity_up()


func _on_checkpoint_3_body_entered(_body):
	$ControllerTips.show_gravity_down()


func _on_checkpoint_4_body_entered(_body):
	$ControllerTips.show_gravity_right()


func _on_checkpoint_5_body_entered(_body):
	if GravityInformation.get_up_direction() == Vector2.LEFT:
		GravityInformation.update_up_direction(Vector2.UP)
