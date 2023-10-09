extends HBoxContainer

var parent_size

var pName
var wins
var streak
var played

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not parent_size:
		parent_size = get_parent_area_size()
		set_size(parent_size)


func update_content(player):
	pName = player.playerName
	wins = player.wins
	streak = player.streak
	played = player.played
	update_labels()
	

func update_labels():
	var labels = get_children()
	labels[1].text = pName
	labels[2].text = str(wins)
	labels[3].text = str(streak)
	labels[4].text = str(played)
