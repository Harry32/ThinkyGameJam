extends StaticBody2D

var closedPosition : Vector2
var state : String = "Closed"


func _ready():
	closedPosition = position


func _process(_delta):
	if state == "Closed" and position.y != closedPosition.y:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(position.x, closedPosition.y), 1)
	
	if state == "Opened" and (position.y != closedPosition.y - 200):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(position.x, closedPosition.y - 200), 1)


func open():
	state = "Opened"


func close():
	state = "Closed"
