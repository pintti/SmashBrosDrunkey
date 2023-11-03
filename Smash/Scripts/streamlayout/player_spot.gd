extends Control

var fireframe = randi()%25
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    fireframe += 0.1
    if fireframe >= 25:
        fireframe = 0
    $HBoxContainer/Wins/FireHolder/Firesheet.frame = int(fireframe)
    

func set_values(pname, texture, wins, leader=false, jonne=false, flaming=false):
    $HBoxContainer/NameHolder/Name.text = pname
    $HBoxContainer/Wins.text = str(wins)
    $HBoxContainer/Control/TextureRect.texture = texture
    if leader:
        $HBoxContainer/NameHolder/Name/Crownholder.show()
    else:
        $HBoxContainer/NameHolder/Name/Crownholder.hide()
    if jonne:
        $HBoxContainer/NameHolder/Name/Jonneholder.show()
    else:
        $HBoxContainer/NameHolder/Name/Jonneholder.hide()
    if flaming:
        $HBoxContainer/Wins/FireHolder.show()
    else:
        $HBoxContainer/Wins/FireHolder.hide()
        
    
