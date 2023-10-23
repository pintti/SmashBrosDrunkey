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
func _process(_delta):
	$ColorRect.color = Color8(red, green, blue, 100)


func _on_button_pressed():
	var playerName = $LineEdit.text
	if playerName and playerName not in players and chosenNode:
		$LineEdit.text = ""
		players[playerName] = {"sprite": chosenSprite.texture.resource_path}
		chosenNodes.append(chosenNode)
		chosenNode._on_char_selected(playerName)
		chosenNode = null
		chosenSprite = null
		$RichTextLabel.modulate = Color(1, 1, 1)
	else:
		$RichTextLabel.modulate = Color(1, 0, 0)

func _on_sprite_selected(node, sprite):
	if chosenNode and chosenNode not in chosenNodes:
		chosenSprite.modulate = Color(1, 1, 1)
		chosenNode.chosen = false
	chosenNode = node
	chosenSprite = sprite


func _on_smash_button_pressed():
	if $DrinkAmount.text:
		var smash_players = FileAccess.open("smashers.smash", FileAccess.WRITE)
		var json_players = JSON.stringify(players)
		smash_players.store_line(json_players)
		var json_drink_amount = JSON.stringify($DrinkAmount.text)
		smash_players.store_line(json_drink_amount)
		get_tree().change_scene_to_file("res://Scripts/Smash.tscn")
	else:
		$DrinkAmount.modulate = Color(1, 0, 0)


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
	if new_text != "joensuu":
		$SpriteButton82.chosen = true
	elif "joensuu" not in players:
		$SpriteButton82.chosen = false
		$SpriteButton82/Sprite2D.modulate = Color(1, 1, 1)
	if new_text != "jaajo":
		$SpriteButton79.chosen = true
	elif "jaajo" not in players:
		$SpriteButton79.chosen = false
		$SpriteButton79/Sprite2D.modulate = Color(1, 1, 1)


func _on_drink_amount_text_changed(new_text):
	$DrinkAmount.modulate = Color(1, 1, 1)
