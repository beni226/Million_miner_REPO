extends CanvasLayer

#when Respawn button is pressed it will restart game
func _on_respawn_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

#When quit button is pressed it will end game
func _on_quit_pressed() -> void:
	get_tree().quit()
