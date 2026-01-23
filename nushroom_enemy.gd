extends CharacterBody2D

var speed = 80
var player_chase = false
var player = null

func _ready() -> void:
		$AnimatedSprite2D.play("idle")

#Gravity
func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0

	# Chase movement (horizontal only if you want platformer behavior)
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
	
	


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		print("working")
		player = body
		player_chase = true


func _on_detection_area_body_exited(_body: Node2D) -> void:
	player = null
	player_chase = false
