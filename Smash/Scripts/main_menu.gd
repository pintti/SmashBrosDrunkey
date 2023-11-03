extends Node


func _on_kys_pressed():
    get_tree().quit()


func _on_palauta_pressed():
    get_node("/root/Restore").restore_state = true
    get_tree().change_scene_to_file("res://Scripts/Smash.tscn")


func _on_smash_pressed():
    get_tree().change_scene_to_file("res://Scripts/char_select.tscn")
