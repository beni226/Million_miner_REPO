extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
var jump_count = 0
const MAX_JUMPS = 1
var move_speed := 100.0
const DIG_OFFSET_DOWN  = Vector2(25, -35)
var bomb2 = Vector2(15,-35)
var bomb3=Vector2(47,-35)
const DIG_OFFSET_LEFT  = Vector2(15, -45)
const DIG_OFFSET_RIGHT = Vector2(47, -45)
const DIG_OFFSET_UP    = Vector2(25, -65)

#Game count down
var game_timer: Timer
var time_left := 300




@onready var item = preload("res://slot.tscn")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if has_item("double jump"):
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
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		
	#Digging action comand
	
	if Input.is_action_just_pressed("dig"):
		dig()
	if Input.is_action_just_pressed("digL"):
		dig2()
	if Input.is_action_just_pressed("digR"):
		dig3()
	if Input.is_action_just_pressed("digU"):
		dig4()
	if has_item("speed potion"):
		move_speed = 160.0
	else:
		move_speed = 100.0
	if has_item("bomb"):
		if Input.is_action_just_pressed("bomb"):
			bomb(DIG_OFFSET_DOWN, bomb2, bomb3)

	move_and_slide()
	#Digging action script
func dig():
	_dig_at_offset(DIG_OFFSET_DOWN)

func dig2():
	_dig_at_offset(DIG_OFFSET_LEFT)

func dig3():
	_dig_at_offset(DIG_OFFSET_RIGHT)

func dig4():
	_dig_at_offset(DIG_OFFSET_UP)

func _dig_at_offset(offset: Vector2):
	var tilemap = get_parent().get_node("TileMap")
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + offset)

	tilemap.set_cell(0, cell, -1)
	tilemap.set_cell(1, cell, -1)

	if has_item("pickaxe upgrade"):
		var extra_cell = tilemap.local_to_map(local_pos + offset + Vector2(0, -16))
		tilemap.set_cell(0, extra_cell, -1)
		tilemap.set_cell(1, extra_cell, -1)
func bomb(offset: Vector2, offset2: Vector2, offset3: Vector2):
	var tilemap = get_parent().get_node("TileMap")
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + offset)
	var cell1 = tilemap.local_to_map(local_pos + offset2)
	var cell2 = tilemap.local_to_map(local_pos + offset3)

	tilemap.set_cell(0, cell, -1)
	tilemap.set_cell(1, cell, -1)
	tilemap.set_cell(0, cell1, -1)
	tilemap.set_cell(1, cell1, -1)
	tilemap.set_cell(0, cell2, -1)
	tilemap.set_cell(1, cell2, -1)

	
	
func _ready():
	add_to_group("players")

	game_timer = Timer.new()
	game_timer.wait_time = time_left
	game_timer.one_shot = true
	game_timer.autostart = false
	add_child(game_timer)

	game_timer.timeout.connect(_on_timer_timeout)
	game_timer.start()

	
func _on_timer_timeout():
	die() # add another win sceen

#func _process(_delta):
	#if game_timer:
		#time_left = int(game_timer.time_left)
		#$CanvasLayer/TimerLabel.text = str(time_left)



#win function
func win():
	get_tree().change_scene_to_file("res://Game win.tscn")
	
	#call_deferred("_go_to_game_win")
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
	
func has_item(item_name: String) -> bool:
	for i in Global.inventory.keys():
		if Global.inventory[i]["name"] == item_name:
			return true
	return false
