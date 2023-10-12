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

var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = load("res://Scripts/Player.gd")
	for player in testPlayers:
		var newPlayer = Player.new()
		newPlayer.playerName = player
		newPlayer.add_texture(testPlayers[player]["sprite"])
		players.append(newPlayer)
	shuffle_players(players)
	_get_player_positions()
	_assign_player_start_pos()
	
	for player in players:
		add_child(player)
		player._add_name()
		
	$PlayerPanel.fill_panel(players)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _assign_player_start_pos():
	for i in len(players):
		players[i].move(positions[i].position)


func shuffle_players(playerNames):
	var playersCopy = []
	for i in len(players):
		var chosenPlayer = players.pick_random()
		chosenPlayer.pos = i
		playersCopy.append(chosenPlayer)
		players.erase(chosenPlayer)
	players.assign(playersCopy)


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
			players[i].played += 1
			if players[i].pos != number:
				players[i].streak += 1
			else:
				players[i].wins += 1
				players[i].pos = len(players)-1
				players[i].streak = 0

	for i in len(players):
		players[i].move(positions[players[i].pos].position) # I will not ask for forgiveness
	var copyPlayers = players
	copyPlayers.sort_custom(_custom_sort)
	for i in len(copyPlayers):
		var playerIndex = players.find(copyPlayers[i])
		players[playerIndex].scorePos = i
	$PlayerPanel.update_standings(players)

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
