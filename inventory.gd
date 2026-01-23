extends CanvasLayer
func _ready() -> void:
	pass # Replace with function body.
func _process(delta: float) -> void:
	pass



func _on_close_pressed() -> void:
	get_node("Anim").play("TransOut")
	

func _input(event):
	if event.is_action_pressed("inv"):
		if self.offset.y == -400:
			get_node("Anim").play("TransIn")
		elif self.offset.y == -500:
			get_node("Anim").play("TransIn")
		elif self.offset.y == 0:
			get_node("Anim").play("TransOut")
		
	
