extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -200.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("ui_down") and is_on_floor():
		$AnimatedSprite2D.play("crouch")
	else:
		$AnimatedSprite2D.play("idle")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#Digging action comand
	
	if Input.is_action_just_pressed("Dig"):
		dig()

	move_and_slide()
	#Digging action script
func dig():
	var tilemap = get_parent().get_node("TileMap") # Adjust path to your TileMap
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(25,35)) # Offset to dig below player
	tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
