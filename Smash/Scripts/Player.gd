extends Sprite2D

var wins = 0
var streak = 0
var pos = 0
var losses = 0
var mod = 1

var fighting = false
var dnf = false

var playerName
var charSize
var playerSprite

func _ready():
	pass


func _process(delta):
	if pos < 4:
		pass
		# Tween here


func move(newPos):
	if position == Vector2(0, 0):
		position = newPos
		if pos > 1 and pos < 5:
			playerSprite.flip_h = true
		if pos > 8:
			playerSprite.flip_h = true


func _add_name():
	var nameLabel = Label.new()
	charSize = playerSprite.get_rect()
	add_child(nameLabel)
	nameLabel.text = playerName
	nameLabel.position += Vector2(-charSize.end.x, charSize.end.y/1.2)


func add_texture(texture_path):
	playerSprite = Sprite2D.new()
	playerSprite.texture = load(texture_path)
	add_child(playerSprite)
