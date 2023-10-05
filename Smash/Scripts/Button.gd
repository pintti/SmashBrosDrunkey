extends Button

var chosen = false

var colorNormal = Color(1, 1, 1)
var colorChosen = Color(0.1, 0.1, 0.1)
var colorHovered = Color(0.7, 0.7, 0.7)
var colorClicked = Color(1.5, 1.5, 1.5, 1.5)


# Called when the node enters the scene tree for the first time.
func _ready():
	self_modulate = Color(0, 0, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not chosen and not is_hovered():
		$Sprite2D.modulate = colorNormal


func _on_pressed():
	if not chosen:
		$Sprite2D.modulate = colorClicked
		chosen = true
		var parent = get_parent()
		parent._on_sprite_selected(self ,$Sprite2D)

func _on_mouse_entered():
	if not chosen:
		$Sprite2D.modulate = colorHovered
	

func _on_mouse_exited():
	if not chosen:
		$Sprite2D.modulate = colorNormal


func _on_char_selected(pName):
	$Sprite2D.modulate = colorChosen
	chosen = true
	var playerName = Label.new()
	playerName.text = pName
	add_child(playerName)
