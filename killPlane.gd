extends Area2D

@export var kill_delay := 5.0          # Optional delay before death
@export var killzone_size := Vector2(64, 64)

@onready var collision := $CollisionShape2D

func _ready():
	# Create a unique collision shape for this instance
	var shape := RectangleShape2D.new()
	shape.size = killzone_size
	collision.shape = shape
'''	
func kill_delay_timer(kill_delay):
	while kill_delay 
'''

func _on_body_entered(body):
	if body.is_in_group("players"):
		if kill_delay > 0:
			await get_tree().create_timer(kill_delay).timeout
		body.die()
