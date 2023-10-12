extends HBoxContainer

var parent_size

var newPosition

var pName
var wins
var streak
var played

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not parent_size:
		parent_size = get_parent_area_size()
		set_size(parent_size)
	if newPosition:
		if global_position.distance_to(newPosition) > 5:
			#print("not at right position: ", global_position, " != ", newPosition)
			var dir = global_position.direction_to(newPosition) * abs((global_position - newPosition)) / 15
			position += dir
		else:
			global_position = newPosition
	else:
		newPosition = global_position


func update_content(player):
	if not player.playerBox:
		player.playerBox = self
	pName = player.playerName
	wins = player.wins
	streak = player.streak
	played = player.played
	update_labels()
	

func update_labels():
	var labels = get_children()
	labels[0].text = pName
	labels[1].text = str(wins)
	labels[2].text = str(streak)
	labels[3].text = str(played)
