extends Node2D


var normalColor: Color = Color(0.356863, 0.92549, 0.945098, 1)
var blinkColor: Color = Color(1, 1, 1, 1)
var tween: Tween


func _ready():
	$Label.label_settings.font_color = normalColor


func set_text(text: String, blink: bool = true):
	$Label.text = text
	
	if blink:
		blink_text()


func blink_text():
	$Label.label_settings.font_color = blinkColor
	var tree = get_tree()

	if tween != null:
		tween.kill()

	if tree != null:
		tween = tree.create_tween().set_loops(3)
		tween.tween_property($Label, "visible", false, 0.5)
		tween.tween_property($Label, "visible", true, 0.5)
		tween.connect("finished", end_blinking)

func end_blinking():
	$Label.label_settings.font_color = normalColor


func _on_tree_exiting():
	if tween != null:
		tween.kill()
