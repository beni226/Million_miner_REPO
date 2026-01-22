extends Area2D

@export var kill_delay := 3.0
@export var killzone_size := Vector2(64, 64)

@onready var collision := $CollisionShape2D
@onready var timer := $Timer

var player_inside: Node = null

	

func _ready():
	if collision.shape == null:
		var shape := RectangleShape2D.new()
		shape.size = killzone_size
		collision.shape = shape


	# Configure the timer
	timer.wait_time = kill_delay

func _on_body_entered(body):
	if body.is_in_group("players"):
		player_inside = body
		timer.start()  # start 3-second countdown
		

func _on_body_exited(body):
	if body == player_inside:
		player_inside = null
		timer.stop()   # cancel if player leaves early


func _on_timer_timeout():
	if player_inside:
		player_inside.die()  # kill the player
		
