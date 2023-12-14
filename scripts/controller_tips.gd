extends CanvasLayer

var position: Vector2
var controlArray: Array

func _ready():
	position = $VBoxContainer.position
	show_move()


func _process(_delta):
	$VBoxContainer.position = $VBoxContainer.position.lerp(position, 1)


func set_position(newPosition: Vector2):
	position = newPosition


func show_move():
	$VBoxContainer/Text/Label.text = "Move"
	
	$VBoxContainer/Keys11.visible = true
	$VBoxContainer/Keys12.visible = false
	$VBoxContainer/Keys21.visible = true
	$VBoxContainer/Keys22.visible = false
	$VBoxContainer/LongKey1.visible = false
	$VBoxContainer/LongKey2.visible = false
	
	controlArray = [$VBoxContainer/Keys11, $VBoxContainer/Keys12, $VBoxContainer/Keys21, $VBoxContainer/Keys22]


func show_jump():
	$VBoxContainer/Text/Label.text = "Jump"
	
	$VBoxContainer/Keys11.visible = false
	$VBoxContainer/Keys12.visible = false
	$VBoxContainer/Keys21.visible = false
	$VBoxContainer/Keys22.visible = false
	$VBoxContainer/LongKey1.visible = true
	$VBoxContainer/LongKey2.visible = false
	
	controlArray = [$VBoxContainer/LongKey1, $VBoxContainer/LongKey2]


func show_gravity_up():
	$VBoxContainer/Text/Label.text = "Change Gravity"
	
	$VBoxContainer/Keys11.visible = false
	$VBoxContainer/Keys12.visible = false
	$VBoxContainer/Keys21.visible = false
	$VBoxContainer/Keys22.visible = false
	$VBoxContainer/LongKey1.visible = false
	$VBoxContainer/LongKey2.visible = false
	$VBoxContainer/ComboKeys11.visible = true
	$VBoxContainer/ComboKeys12.visible = false
	$VBoxContainer/ComboKeys21.visible = true
	$VBoxContainer/ComboKeys22.visible = false
	
	controlArray = [$VBoxContainer/ComboKeys11, $VBoxContainer/ComboKeys12, $VBoxContainer/ComboKeys21, $VBoxContainer/ComboKeys22]
	
func show_gravity_down():
	$VBoxContainer/Text/Label.text = "Change Gravity"
	
	$VBoxContainer/Keys11.visible = false
	$VBoxContainer/Keys12.visible = false
	$VBoxContainer/Keys21.visible = false
	$VBoxContainer/Keys22.visible = false
	$VBoxContainer/LongKey1.visible = false
	$VBoxContainer/LongKey2.visible = false
	
	$VBoxContainer/ComboKeys11/Key2.texture = preload("res://graphics/ui/Input Key - S.png")
	$VBoxContainer/ComboKeys12/Key2.texture = preload("res://graphics/ui/Input Key - S (Pressed).png")
	$VBoxContainer/ComboKeys21/Key2.texture = preload("res://graphics/ui/Input Key - Down.png")
	$VBoxContainer/ComboKeys22/Key2.texture = preload("res://graphics/ui/Input Key - Down (Pressed).png")
	
	$VBoxContainer/ComboKeys11.visible = true
	$VBoxContainer/ComboKeys12.visible = false
	$VBoxContainer/ComboKeys21.visible = true
	$VBoxContainer/ComboKeys22.visible = false
	
	controlArray = [$VBoxContainer/ComboKeys11, $VBoxContainer/ComboKeys12, $VBoxContainer/ComboKeys21, $VBoxContainer/ComboKeys22]


func show_gravity_right():
	$VBoxContainer/Text/Label.text = "Change Gravity"
	
	$VBoxContainer/Keys11.visible = false
	$VBoxContainer/Keys12.visible = false
	$VBoxContainer/Keys21.visible = false
	$VBoxContainer/Keys22.visible = false
	$VBoxContainer/LongKey1.visible = false
	$VBoxContainer/LongKey2.visible = false
	
	$VBoxContainer/ComboKeys11/Key2.texture = preload("res://graphics/ui/Input Key - D.png")
	$VBoxContainer/ComboKeys12/Key2.texture = preload("res://graphics/ui/Input Key - D (Pressed).png")
	$VBoxContainer/ComboKeys21/Key2.texture = preload("res://graphics/ui/Input Key - Right.png")
	$VBoxContainer/ComboKeys22/Key2.texture = preload("res://graphics/ui/Input Key - Right (Pressed).png")
	
	$VBoxContainer/ComboKeys11.visible = true
	$VBoxContainer/ComboKeys12.visible = false
	$VBoxContainer/ComboKeys21.visible = true
	$VBoxContainer/ComboKeys22.visible = false
	
	controlArray = [$VBoxContainer/ComboKeys11, $VBoxContainer/ComboKeys12, $VBoxContainer/ComboKeys21, $VBoxContainer/ComboKeys22]

func _on_timer_1s_timeout():
	toggle_keys_visibility()


func toggle_keys_visibility():
	for item in controlArray:
		item.visible = not item.visible
