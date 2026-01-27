extends CharacterBody2D

var speed = 70
var player_chase = false
var player = null
var facing := 1

var jump_velocity: float = -220
var jump_cooldown: float = 0.0
var jump_cooldown_time: float = 0.5  # half a second between jumps


func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	
	
	jump_cooldown = max(jump_cooldown - delta, 0)
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
		
	# Chase movement
	if player_chase and player:
		facing = sign(player.global_position.x - global_position.x)

		# Update ray directions
		$WallCheck.target_position.x = facing * 12
		$GroundCheck.target_position.x = facing * 12

		velocity.x = facing * speed
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = facing > 0

		try_jump()
	else:
		velocity.x = 0
		$AnimatedSprite2D.play("idle")

	move_and_slide()

func try_jump():
	# Only jump from ground
	if not is_on_floor():
		return
		
	# Only jump if cooldown is done
	if jump_cooldown > 0:
		return
#Don't jump just because player is above (pit case)
	if player.global_position.y < global_position.y - 32:
		return

	# Check for wall in front (must be close enough))
	var wall_ahead: bool = false
	if $WallCheck.is_colliding():
		var wall_pos = $WallCheck.get_collision_point()
		if abs(wall_pos.x - global_position.x) < 16:  # small distance threshold
			wall_ahead = true

	# Check for gap ahead (must be in front)
	var gap_ahead: bool = false
	if not $GroundCheck.is_colliding():
		var ground_pos = $GroundCheck.get_collision_point()
		if abs(ground_pos.x - global_position.x) < 16:
			gap_ahead = true
		else:
			gap_ahead = true  # fallback if ray doesn't hit anything

	if wall_ahead or gap_ahead:
		velocity.y = jump_velocity
		jump_cooldown = jump_cooldown_time  # reset cooldown
		
'''
	# Old Chase movement 
	if player_chase :
		var direction = (player.position - position).normalized()
		velocity.x = direction.x * speed
		$AnimatedSprite2D.play("run")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = 0
		$AnimatedSprite2D.play("idle")
		
	move_and_slide()
	'''
	


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		print("working")
		player = body
		player_chase = true


func _on_detection_area_body_exited(_body: Node2D) -> void:
	player = null
	player_chase = false
