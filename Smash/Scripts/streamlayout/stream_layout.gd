extends VBoxContainer

var playercount = 0
var playerlist = []

func update_visuals(players):
    var jonnestreak = -1
    if playercount == len(players):
        var all_played = true
        for p in players:
            if p.wins == 0:
                if not all_played:
                    jonnestreak = -1
                    break
                all_played = false
            if p.streak > jonnestreak:
                jonnestreak = p.streak
        for i in playerlist:
            var jonne = false
            if is_instance_valid(i.player):
                if i.player.streak == jonnestreak:
                    jonne = true
                i.update_values(false, jonne)
                $Main/LeftBar/Playerlist.move_child(i, i.player.scorePos)
    else:
        playercount = len(players)
        playerlist = []
        for child in $Main/LeftBar/Playerlist.get_children():
            child.queue_free()
        for p in players:
            var pspot:Control = load("res://Scripts/streamlayout/playerlist_spot.tscn").instantiate()
            pspot.size_flags_vertical = Control.SIZE_EXPAND_FILL
            $Main/LeftBar/Playerlist.add_child(pspot)
            pspot.player = p
            pspot.update_values(true)
            playerlist.append(pspot)
            
    for p in players:
        if p.pos > 3:
            continue
        var leader = false
        if p.wins > 0 and p.scorePos == 0:
            leader = true
        var jonne = false
        if p.streak == jonnestreak:
            jonne = true
        var flaming = false
        if p.streak > 4:
            flaming = true
        $Main/Right/Bottom.get_child(p.pos).set_values(p.playerName, p.playerSprite.texture, p.wins, p.played, leader, jonne, flaming)
        
