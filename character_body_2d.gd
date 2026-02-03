extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
var jump_count = 0
const MAX_JUMPS = 2


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")):
		if jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1	
		if is_on_floor():
			jump_count = 0
		
	if Input.is_action_pressed("ui_down") and is_on_floor():
		$AnimatedSprite2D.play("crouch")
	elif Input.is_action_pressed("ui_left"):
			if $AnimatedSprite2D.animation != "moveL":
				$AnimatedSprite2D.flip_h = true   
				$AnimatedSprite2D.play("moveL")
	elif Input.is_action_pressed("ui_right"):
		if $AnimatedSprite2D.animation != "moveR":
			$AnimatedSprite2D.flip_h = false   
			$AnimatedSprite2D.play("moveR")
	elif Input.is_action_pressed("ui_right") and $AnimatedSprite2D.animation("crouch"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("roll")
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("roll")
	else:
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.flip_h = false   







	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#Digging action comand
	
	if Input.is_action_just_pressed("dig"):
		dig()
	if Input.is_action_just_pressed("digL"):
		dig2()
	if Input.is_action_just_pressed("digR"):
		dig3()
	if Input.is_action_just_pressed("digU"):
		dig4()

	move_and_slide()
	#Digging action script
func dig():
	var tilemap = get_parent().get_node("TileMap") # Adjust path to your TileMap
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(25,-35)) # Offset to dig below player
	tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
	tilemap.set_cell(1,cell,-1)

func dig2():
	var tilemap = get_parent().get_node("TileMap") # Adjust path to your TileMap
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(15, -45))
	tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
	tilemap.set_cell(1,cell,-1)	

func dig3():
	var tilemap = get_parent().get_node("TileMap") # Adjust path to your TileMap
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(47, -45)) # Offset to dig below player
	tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
	tilemap.set_cell(1,cell,-1)	
func dig4():
	var tilemap = get_parent().get_node("TileMap") # Adjust path to your TileMap
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(25,-65)) # Offset to dig below player
	tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
	tilemap.set_cell(1,cell,-1)
	
	
func _ready():
	add_to_group("players")

	
#Death function
func die():
	#$AnimatedSprite2D.play("death")
	#get_tree().change_scene_to_file("res://GameOver.tscn")
	call_deferred("_go_to_game_over")

	# Move player to respawn point
	global_position = Vector2(100, 100) # Change to your respawn point

	# Reset movement
	velocity = Vector2.ZERO
	jump_count = 0

	# Temporarily disable collision to avoid instantly re-triggering death zone
	set_deferred("collision_layer", 0)
	set_deferred("collision_mask", 0)
	
	# Restore collisions next frame
	call_deferred("_restore_collision")

func _restore_collision():
	collision_layer = 1
	collision_mask = 1
	
func _go_to_game_over():
	get_tree().change_scene_to_file("res://GameOver.tscn")
