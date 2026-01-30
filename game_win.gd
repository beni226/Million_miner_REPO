extends CanvasLayer



#When quit button is pressed it will end game
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
