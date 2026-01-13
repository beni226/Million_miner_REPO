extends CanvasLayer

func _on_close_pressed() -> void:
	get_node("Anim").play("TransOut")
 
