extends VBoxContainer

var boxes = []
var cont_size
var noob_rect
var noob_rect_color

var dnf_amount = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	boxes = get_children()
	boxes.remove_at(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func fill_panel(players):
	var boxCopy = []
	for i in len(boxes):
		if i < len(players):
			fill_rect(players[i], boxes[players[i].pos])
			boxCopy.append(boxes[players[i].pos])
		else:
			boxes[i].visible = false
	boxes = boxCopy


func fill_panel_restore(players):
	var boxCopy = []
	for i in len(boxes):
		if i < len(players):
			fill_rect(players[i], boxes[players[i].beginPos])
			boxCopy.append(boxes[players[i].beginPos])
		else:
			boxes[i].visible = false
	boxes = boxCopy


func fill_rect(player, rect):
	rect.get_child(0).update_content(player)


func add_noob(player, rect, noob):
	if player == noob:
		if noob_rect:
			noob_rect.color = noob_rect_color
		noob_rect = rect
		noob_rect_color = rect.color
		rect.color = "#00CC00"
	elif rect.color == Color("#00CC00"):
		rect.color = noob_rect_color
		noob_rect = null
		noob_rect_color = null


func update_standings(players):
	var noob = _check_for_noob(players)
	for i in len(players):
		var newPosition = boxes[i].global_position
		players[i].playerBox.newPosition = newPosition
		players[i].playerBox.update_content(players[i])
		add_noob(players[i], boxes[i], noob)


func _check_for_noob(players):
	var streaker = null
	for player in players:
		if player.wins == 0:
			return
		if not streaker:
			streaker = player
		elif streaker.streak < player.streak:
			streaker = player
	return streaker

func move_dnf(player):
	var newPosition = boxes[dnf_amount].global_position
	player.playerBox.newPosition = newPosition
	boxes[dnf_amount].color = "#424949"
	dnf_amount -= 1


func winner_chicken_dinner(players):
	update_standings(players)
	boxes[0].color = "#F4C000"
