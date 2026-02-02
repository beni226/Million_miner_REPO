extends RigidBody2D

func _on_body_shape_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		self.queue_free()
