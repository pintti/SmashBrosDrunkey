extends CharacterBody2D

var wins = 0
var streak = 0
var pos = 0
var scorePos = 0
var played = 0
var mod = 1

var new_position = Vector2(0, 0)

var fighting = false
var dnf = false

var playerName
var charSize
var playerSprite
var playerBoxColor

func _ready():
	add_to_group("players")


func _process(delta):
	if pos < 4 and not fighting:
		pass
		# Tween here
	if position.distance_to(new_position) > 5:
		velocity = position.direction_to(new_position) * 700
		move_and_slide()
	else:
		position = new_position

func move(newPos):
	new_position = newPos
	if position == Vector2(0, 0):
		position = new_position
	if pos < 2 or pos == 4:
		playerSprite.flip_h = true
	elif pos > 8:
		playerSprite.flip_h = true
	else:
		playerSprite.flip_h = false


func _add_name():
	var nameLabel = Label.new()
	add_child(nameLabel)
	nameLabel.size.x = playerSprite.texture.get_size().x
	nameLabel.text = playerName
	nameLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	nameLabel.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	nameLabel.position += Vector2(-playerSprite.texture.get_size().x/2, 40)


func add_texture(texture_path):
	playerSprite = Sprite2D.new()
	playerSprite.texture = load(texture_path)
	add_child(playerSprite)
