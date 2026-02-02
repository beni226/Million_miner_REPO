extends Area2D

func _input(event):
	if event.is_action_pressed("shop"):
		get_node("shop/Anim").play("TransIn")
