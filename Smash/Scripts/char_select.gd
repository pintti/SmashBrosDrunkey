extends Node

var players = {}
var chosenNodes = []

var chosenNode = null
var chosenSprite = null

var red = 0
var green = 0
var blue = 255

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpriteButton82.chosen = true
	$SpriteButton79.chosen = true
	$SpriteButton82/Sprite2D.modulate = Color(0.1, 0.1, 0.1)
	$SpriteButton79/Sprite2D.modulate = Color(0.1, 0.1, 0.1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ColorRect.color = Color8(red, green, blue, 100)


func _on_button_pressed():
	var playerName = $LineEdit.text
	if playerName and playerName not in players and chosenNode:
		$LineEdit.text = ""
		players[playerName] = {"sprite": chosenSprite.texture.resource_path}
		chosenNodes.append(chosenNode)
		print(players)
		chosenNode._on_char_selected()
		chosenNode = null
		chosenSprite = null

func _on_sprite_selected(node, sprite):
	if chosenNode and chosenNode not in chosenNodes:
		chosenSprite.modulate = Color(1, 1, 1)
		chosenNode.chosen = false
	chosenNode = node
	chosenSprite = sprite


func _on_smash_button_pressed():
	pass # Replace with function body.


func _on_timer_timeout():
	if red < 255 and blue == 0 and green == 0:
		red += 1
	elif red == 255 and green < 255 and blue == 0:
		green += 1
	elif red > 0 and green == 255 and blue == 0:
		red -= 1
	elif green == 255 and blue < 255 and red == 0:
		blue += 1
	elif green > 0 and blue == 255 and red == 0:
		green -= 1
	elif blue == 255 and red < 255 and green == 0:
		red += 1
	else:
		blue -= 1


func _on_line_edit_text_changed(new_text):
	if new_text != "Joensuu":
		$SpriteButton82.chosen = true
	elif "Joensuu" not in players:
		$SpriteButton82.chosen = false
		$SpriteButton82/Sprite2D.modulate = Color(1, 1, 1)
	if new_text != "Jaajo":
		$SpriteButton79.chosen = true
	elif "Jaajo" not in players:
		$SpriteButton79.chosen = false
		$SpriteButton79/Sprite2D.modulate = Color(1, 1, 1)
