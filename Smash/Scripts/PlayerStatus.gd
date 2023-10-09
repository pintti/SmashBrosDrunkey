extends VBoxContainer

var boxes = []
var cont_size

# Called when the node enters the scene tree for the first time.
func _ready():
	boxes = get_children()
	boxes.remove_at(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func fill_panel(players):
	for i in len(boxes):
		if i < len(players):
			boxes[i].get_child(0).update_content(players[i])
		else:
			boxes[i].visible = false

func fill_rect(player, rect):
	var labels = rect.get_child(0).get_children()
	labels[1].text = str(player.playerName)
	labels[2].text = str(player.wins)
	labels[3].text = str(player.streak)
	labels[4].text = str(player.played)

func update_standings(players):
	for player in players:
		for box in boxes:
			pass

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

