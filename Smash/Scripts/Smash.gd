extends Node

var testPlayers = { 
	"Mario": { "sprite": "res://Pics/Fighters/Mario.png" }, 
	"Donkey Kong": { "sprite": "res://Pics/Fighters/DonkeyKong.png" }, 
	"Terry": { "sprite": "res://Pics/Fighters/Terry.png" }, 
	"Incineroar": { "sprite": "res://Pics/Fighters/Incineroar.png" }, 
	"KRool": { "sprite": "res://Pics/Fighters/Krool.png" }, 
	"Bowser": { "sprite": "res://Pics/Fighters/Bowser.png" }, 
	"Kirby": { "sprite": "res://Pics/Fighters/Kirby.png" }, 
	"Dedede": { "sprite": "res://Pics/Fighters/DDD.png" }, 
	"Wario": { "sprite": "res://Pics/Fighters/Wario.png" }, 
	"Ike": { "sprite": "res://Pics/Fighters/Ike.png" }, 
	"Ridley": { "sprite": "res://Pics/Fighters/Ridley.png" }, 
	"Jigglypuff": { "sprite": "res://Pics/Fighters/Jiggly.png" } 
}

var players = []
var positions = []

var dnf_amount = 0
var dnf_players = []

var Player
var tween

var skip = false
var dnf = false

var start_pos = []
var made_actions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = load("res://Scripts/Player.gd")
	var data = FileAccess.open("smashers.smash", FileAccess.READ)
	if data:
		var json_string = data.get_line()
		var json = JSON.new()
		var error = json.parse(json_string)
		testPlayers = json.data

	for player in testPlayers:
		var newPlayer = Player.new()
		newPlayer.playerName = player
		newPlayer.add_texture(testPlayers[player]["sprite"])
		players.append(newPlayer)
	shuffle_players()
	_get_player_positions()
	_assign_player_start_pos()
	
	for player in players:
		add_child(player)
		player._add_name()
		$Button/DNFButton.get_popup().add_item(player.playerName)
	$Button/DNFButton.get_popup().index_pressed.connect(_on_dnf_button_pressed)	
	$PlayerPanel.fill_panel(players)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _assign_player_start_pos():
	for i in len(players):
		players[i].move(positions[i].position)


func shuffle_players():
	var playersCopy = []
	for i in len(players):
		var chosenPlayer = players.pick_random()
		chosenPlayer.pos = i
		playersCopy.append(chosenPlayer)
		players.erase(chosenPlayer)
	players.assign(playersCopy)
	start_pos.assign(playersCopy)


func _get_player_positions():
	for child in $playerPositions.get_children():
		positions.append(child)

func _print_all_players():
	for player in players:
		_print_player(player)
	print()

func _print_player(player):
	print(player.playerName, " Wins ", player.wins, " Pos ", player.pos, " Streak ", player.streak, " Played ", player.played)


func winner_move(number):
	for i in len(players):
		if players[i].pos == 4:
			players[i].pos = number
		elif players[i].pos < len(players)+1 and players[i].pos > 4:
			players[i].pos -= 1
		elif players[i].pos < 4:
			if not skip:
				players[i].played += 1
				if players[i].pos != number:
					players[i].streak += 1
				else:
					players[i].wins += 1
					players[i].pos = len(players)-1
					players[i].lastStreak.append(players[i].streak)
					players[i].streak = 0
			elif skip:
				if players[i].pos == number:
					players[i].pos = len(players)-1
					players[i].lastStreak.append(players[i].streak)
					players[i].streak = 0

	for i in len(players):
		players[i].move(positions[players[i].pos].position) # I will not ask for forgiveness
	var copyPlayers = []
	copyPlayers.assign(players)
	copyPlayers.sort_custom(_custom_sort)
	for i in len(copyPlayers):
		var playerIndex = players.find(copyPlayers[i])
		players[playerIndex].scorePos = i
	$PlayerPanel.update_standings(players)
	if skip:
		made_actions.append(-number-1)
	else:
		made_actions.append(number)
	save_state()


func _custom_sort(a, b):
	if a.wins > b.wins:
		return true
	return false


func _on_button_pressed():
	winner_move(0)
func _on_button_2_pressed():
	winner_move(1)
func _on_button_3_pressed():
	winner_move(2)
func _on_button_4_pressed():
	winner_move(3)

func _on_button_toggled(button_pressed):
	if button_pressed:
		$SkipButton.modulate = Color(1, 0, 0)
		skip = true
	else:
		$SkipButton.modulate = Color(1, 1, 1)
		skip = false


func _on_dnf_button_pressed(player):
	var dnf_player = $Button/DNFButton.get_popup().get_item_text(player)
	$Button/DNFButton.get_popup().remove_item(player)
	for curPlayer in players:
		if curPlayer.playerName == dnf_player:
			dnf_action(curPlayer)


func dnf_action(dnf_player):
	var dnf_player_pos = dnf_player.pos
	dnf_players.append(dnf_player)
	dnf_player.dnf = true
	for player in players:
		if dnf_player_pos < 4:
			if player.pos == 4:
				player.pos = dnf_player_pos
			elif player.pos > dnf_player_pos and player.pos > 3:
				player.pos -= 1
		else:
			if player.pos > dnf_player_pos:
				player.pos -= 1
	players.erase(dnf_player)
	$PlayerPanel.move_dnf(dnf_player)
	
	var dnf_spot = $DNFSpot.get_global_rect()
	if dnf_amount < 5:
		dnf_spot = dnf_spot.position + Vector2(50*dnf_amount, 20*dnf_amount)
	else:
		dnf_spot = dnf_spot.position + Vector2(50*(dnf_amount-5), 100*(dnf_amount-4))
	dnf_player.move(dnf_spot)
	dnf_amount += 1
	
	for i in len(players):
		players[i].move(positions[players[i].pos].position)
	$PlayerPanel.update_standings(players)
	#made_actions.append(dnf_player)
	made_actions = []


func _on_revert_button_pressed():
	var last_made_action = made_actions.pop_back()
	if typeof(last_made_action) == TYPE_INT:
		print(last_made_action)
		reverse_move(last_made_action)
	elif typeof(last_made_action) == TYPE_OBJECT:
		print(last_made_action)
	else:
		print(typeof(last_made_action))
		print(last_made_action)


func reverse_move(number):
	if number >= 0:
		for player in players:
			if player.pos == number:
				player.pos = 4
			elif player.pos == len(players)-1:
				player.pos = number
				player.wins -= 1
				player.streak = player.lastStreak.pop_back()
				player.played -= 1
			elif player.pos > number and player.pos > 3:
				player.pos += 1
			elif player.pos < 4 and player.pos != number:
				player.streak -= 1
				player.played -= 1
	else:
		number = abs(number+1)
		for player in players:
			if player.pos == number:
				player.pos = 4
			elif player.pos == len(players)-1:
				player.pos = number
				player.streak = player.lastStreak.pop_back()
			elif player.pos > number and player.pos > 3:
				player.pos += 1
	for i in len(players):
		players[i].move(positions[players[i].pos].position) # I will not ask for forgiveness
	var copyPlayers = []
	copyPlayers.assign(players)
	copyPlayers.sort_custom(_custom_sort)
	for i in len(copyPlayers):
		var playerIndex = players.find(copyPlayers[i])
		players[playerIndex].scorePos = i
	$PlayerPanel.update_standings(players)


func add_dnf_player_back():
	# really?
	pass

func save_state():
	var saved_stats = save()
	var save_loc = FileAccess.open("saveState.save", FileAccess.WRITE)
	var json_string = JSON.stringify(saved_stats)
	save_loc.store_line(json_string)

func save():
	var save_state = {
		"actions": made_actions,
		"players": {}
	}
	for player in start_pos:
		var player_stats = player.save_stats()
		save_state["players"][player.playerName] = player_stats
	return save_state
