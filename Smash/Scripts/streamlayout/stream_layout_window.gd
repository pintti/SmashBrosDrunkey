extends Window

var opened = false
var toggle_view = false

func _process(delta):
    if not opened and Input.is_action_just_pressed("openstreamlayout"):
        show()
        opened = true
    if opened and Input.is_action_just_pressed("toggle_view"):
        toggle_view = !toggle_view
        $MainScreen.visible = toggle_view
        
func _ready():
    $MainScreen.texture = get_parent().get_viewport().get_texture()
    
