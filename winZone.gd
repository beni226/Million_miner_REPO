extends Area2D


@export var kill_delay := 0.0   # optional delay before death

func _on_body_entered(body):
	if body.is_in_group("players"):
		print("working")#Debug
		if kill_delay > 0:
			await get_tree().create_timer(kill_delay).timeout
		body.win()
