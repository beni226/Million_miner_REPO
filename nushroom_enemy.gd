extends CharacterBody2D

@export var speed: float = 70
@export var jump_velocity: float = -300
@export var jump_cooldown_time: float = 0.5  # seconds

@onready var ground_check: RayCast2D = $GroundCheck
@onready var wall_check: RayCast2D = $WallCheck
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var player: Node2D = null
var player_chase: bool = false
var facing: int = 1
var jump_cooldown: float = 0.0

func _ready():
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	jump_cooldown = max(jump_cooldown - delta, 0)

	# Gravity
	velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	velocity.y = min(velocity.y, 400)  # optional clamp

	if player_chase and player:
		chase_player(delta)
	else:
		velocity.x = 0
		animated_sprite.play("idle")

	move_and_slide()

func chase_player(_delta: float) -> void:
	# Determine direction to player
	facing = sign((player.global_position.x + 20) - global_position.x)
	velocity.x = facing * speed
	animated_sprite.play("run")
	animated_sprite.flip_h = facing > 0

	# Update raycast positions if needed
	wall_check.target_position.x = facing * abs(wall_check.target_position.x)
	ground_check.target_position.x = facing * abs(ground_check.target_position.x)

	# Jump logic
	try_jump()

func try_jump():
	# Only jump from floor
	if not is_on_floor():
		return

	# Cooldown
	if jump_cooldown > 0:
		return

	# Check for wall in front
	var wall_ahead: bool = wall_check.is_colliding()

	# Check for gap ahead
	var gap_ahead: bool = not ground_check.is_colliding()

	if wall_ahead or gap_ahead:
		velocity.y = jump_velocity
		jump_cooldown = jump_cooldown_time

# Player detection
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		player_chase = false
