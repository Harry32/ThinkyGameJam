extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	body.set_external_gravity($RayCast2D.target_position)


func _on_body_exited(body):
	body.set_external_gravity(GravityInformation.get_up_direction())
