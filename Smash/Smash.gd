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
	Player = load("res://Player.gd")
	for player in testPlayers:
		var newPlayer = Player.new()
		newPlayer.playerName = player
		newPlayer.texture = load(testPlayers[player]["sprite"])
		players.append(newPlayer)
	shuffle_players(players)
	_get_player_positions()
	_assign_player_start_pos()
	_print_all_players()
	
	for player in players:
		add_child(player)
		player._add_name()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _assign_player_start_pos():
	for i in len(positions):
		players[i].position = positions[i].position
		


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

func _print_player(player):
	print(player.playerName, " Wins ", player.wins, " Pos ", player.pos, " Streak ", player.streak, " Loss ", player.losses, " ", "Vector2 ", player.position)
