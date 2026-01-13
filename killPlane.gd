extends Area2D


@export var kill_delay := 1.0   # optional delay before death
@export var damage_amount := 100 #or insta kill

@export var killzone_size := Vector2(64,64)

@onready var collision := $CollisionShape2D
@onready var time := $Timer


func _on_body_entered(body):
	if body.is_in_group("players"):
		if kill_delay > 0:
			await get_tree().create_timer(kill_delay).timeout
		body.die()
