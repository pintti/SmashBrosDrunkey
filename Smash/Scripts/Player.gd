extends CharacterBody2D

var wins = 0
var streak = 0
var pos = 0
var scorePos = 0
var played = 0
var mod = 1
var beginPos = 0


var new_position = Vector2(0, 0)

var fighting = false
var moving = false
var dnf = false

var lastStreak = []

var playerName
var charSize
var playerSprite
var playerBoxColor
var playerBox
var playerTween


func _ready():
    add_to_group("players")


func _process(_delta):
    if pos < 4:
        fighting = true
    if moving:
        if position.distance_to(new_position) > 10:
            velocity = position.direction_to(new_position) * 700
            move_and_slide()
        else:
            position = new_position
            playerSprite.position = Vector2(0, 0)
            moving = false
    elif pos > 3 and fighting or dnf:
        fighting = false
        if playerTween:
            playerTween.kill()


func tween_player():
    if fighting and pos < 4:
        fighting = true
        playerTween = get_tree().create_tween()
        playerTween.tween_property(playerSprite, "position", Vector2(10*mod, 0), 0.25)
        playerTween.tween_property(playerSprite, "position", Vector2(-20*mod, 0), 0.5)
        playerTween.tween_property(playerSprite, "position", Vector2(10*mod, 0), 0.25)
        playerTween.set_loops()

func move(newPos):
    new_position = newPos
    moving = true
    if position == Vector2(0, 0):
        position = new_position
    if pos < 2 or pos == 4 or pos > 8:
        playerSprite.flip_h = true
        mod = 1
    else:
        playerSprite.flip_h = false
        mod = -1


func _add_name():
    var nameLabel = Label.new()
    add_child(nameLabel)
    nameLabel.size.x = playerSprite.texture.get_size().x
    nameLabel.text = playerName
    nameLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    nameLabel.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
    nameLabel.position += Vector2(-playerSprite.texture.get_size().x/2, 40)


func add_texture(texture_path):
    playerSprite = Sprite2D.new()
    playerSprite.texture = load(texture_path)
    add_child(playerSprite)
    
func save_stats():
    var save_dict = {
        "wins": wins,
        "streak": streak,
        "lastStreak": lastStreak,
        "played": played,
        "pos": pos,
        "scorePos": scorePos,
        "playerSprite": playerSprite.texture.resource_path,
        "playerName": playerName,
        "dnf": dnf,
        "beginPos": beginPos
    }
    return save_dict
    
func kill_tween():
    if playerTween:
        playerTween.kill()
