extends VBoxContainer

var boxes = []
var cont_size
var noob_rect
var noob_rect_color

# Called when the node enters the scene tree for the first time.
func _ready():
	boxes = get_children()
	boxes.remove_at(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func fill_panel(players):
	var boxCopy = []
	for i in len(boxes):
		if i < len(players):
			#players[i].playerBoxColor = boxes[i].color
			fill_rect(players[i], boxes[players[i].pos])
			boxCopy.append(boxes[players[i].pos])
		else:
			boxes[i].visible = false
	boxes = boxCopy


func fill_rect(player, rect, noob=null):
	var labels = rect.get_child(0).get_children()
	labels[0].text = str(player.playerName)
	labels[1].text = str(player.wins)
	labels[2].text = str(player.streak)
	labels[3].text = str(player.played)
	if player == noob:
		if noob_rect:
			noob_rect.color = noob_rect_color
		noob_rect = rect
		noob_rect_color = rect.color
		rect.color = "#00CC00"
	


func update_standings(players):
	var noob = _check_for_noob(players)
	var playerStandings = players
	playerStandings.sort_custom(_custom_sort)
	
	for i in len(playerStandings):
		fill_rect(playerStandings[i], boxes[i], noob)
		

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

func _custom_sort(a, b):
	if a.wins > b.wins:
		return true
	return false

"""
func fill_panel(players):
	create_player_panel("Name", "Wins", "Streak", "Played", 0)
	for i in len(players):
		create_player_panel(players[i].playerName, players[i].wins, players[i].streak, players[i].played, i+1)


func create_player_panel(pName, rwins, rstreak, rplayed, i):
	var container = ColorRect.new()
	if i % 2 == 0:
		container.color = "#CC0033"
	else:
		container.color = "#FF9900"
	container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_child(container)
	
	var hbox = HBoxContainer.new()
	container.add_child(hbox)
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	if i == 0:
		hbox.add_child(_create_label(""))
	else:
		hbox.add_child(_create_label(i))
	hbox.add_child(_create_label(pName))
	hbox.add_child(_create_label(rwins))
	hbox.add_child(_create_label(rstreak))
	hbox.add_child(_create_label(rplayed))
	
	boxes.append(container)

func _create_label(label_text):
	var label = Label.new()
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.text = str(label_text)
	return label
"""

