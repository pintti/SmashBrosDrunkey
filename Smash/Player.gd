extends Sprite2D

var wins = 0
var streak = 0
var pos = 0
var losses = 0

var fighting = false
var dnf = false

var playerName
var charSize

func _ready():
	pass


func _process(_delta):
	if pos > 1:
		flip_h = true


func _add_name():
	var nameLabel = Label.new()
	charSize = get_rect()
	print(charSize.end, " ", charSize.size, charSize.position)
	add_child(nameLabel)
	nameLabel.text = playerName
	#nameLabel.position += Vector2(-charSize.size.x, 0) 
	print(nameLabel.text, " ", nameLabel.size, " ", nameLabel.position)
