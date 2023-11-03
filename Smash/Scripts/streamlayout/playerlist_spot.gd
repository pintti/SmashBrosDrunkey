extends Control

var fireframe = randi()%25
var player = null
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    fireframe += 0.1
    if fireframe >= 25:
        fireframe = 0
    $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak/FireHolder/Firesheet.frame = int(fireframe)



func update_values(all=false, jonne=false):
    if all:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name.text = player.playerName
        $PlayerlistSpot/CenterContainer/Char.texture = player.playerSprite.texture
    
    $PlayerlistSpot/VBoxContainer/HBoxContainer/Wins.text = str(player.wins)
    $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak.text = str(player.streak)
    $PlayerlistSpot/VBoxContainer/HBoxContainer/Played.text = str(player.played)
    var winpers = 0
    if player.played > 0:
        winpers = int((player.wins/float(player.played))*100)
    $PlayerlistSpot/VBoxContainer/HBoxContainer/Percent.text = str(winpers)+"%"

    if player.pos < 4:
        $PlayerlistSpot/VBoxContainer/HBoxContainer/StreakLabel.text = "Streak"
        $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak.text = str(player.streak)
    else:
        $PlayerlistSpot/VBoxContainer/HBoxContainer/StreakLabel.text = "Wait"
        $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak.text = str(player.pos - 3)
        
    if player.scorePos == 0 and player.wins > 0:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name/Crownholder.show()
    else:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name/Crownholder.hide()
    if jonne:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name/Jonneholder.show()
    else:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name/Jonneholder.hide()
    if player.streak > 4:
        $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak/FireHolder.show()
    else:
        $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak/FireHolder.hide()
            
    

func set_values(pname, texture, wins,  played, streak, line=false, leader=false, jonne=false, flaming=false):
    $PlayerlistSpot/VBoxContainer/CenterContainer/Name.text = pname
    $PlayerlistSpot/VBoxContainer/HBoxContainer/Wins.text = str(wins)
    $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak.text = str(streak)
    $PlayerlistSpot/VBoxContainer/HBoxContainer/Played.text = str(played)
    if texture:
        $PlayerlistSpot/CenterContainer/Char.texture = texture
    if line:
        $PlayerlistSpot/VBoxContainer/HBoxContainer/StreakLabel.text = "Wait"
    else:
        $PlayerlistSpot/VBoxContainer/HBoxContainer/StreakLabel.text = "Streak"
        
    if leader:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name/Crownholder.show()
    else:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name/Crownholder.hide()
    if jonne:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name/Jonneholder.show()
    else:
        $PlayerlistSpot/VBoxContainer/CenterContainer/Name/Jonneholder.hide()
    if flaming:
        $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak/FireHolder.show()
    else:
        $PlayerlistSpot/VBoxContainer/HBoxContainer/Streak/FireHolder.hide()
