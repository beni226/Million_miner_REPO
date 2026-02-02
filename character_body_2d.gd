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
		digDown()
	if Input.is_action_just_pressed("digL"):
		digLeft()
	if Input.is_action_just_pressed("digR"):
		digRight()
	if Input.is_action_just_pressed("digU"):
		digUp()

	move_and_slide()

@onready var tilemap = $"../TileMap"
@export var coinsPacked : PackedScene

var isLuckyBlockData = "luckyBlocks"
var isSuperBlockData = "superBlock"
var gold : int = 0
var blocksBroken : int = 0

var randomNum = RandomNumberGenerator.new()

#Digging action scripts
func digDown():
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(0,12)) # Offset to dig below of the player
	var tileData : TileData = tilemap.get_cell_tile_data(0, cell)
	
	if cell != null:
		tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
		blocksBroken += 1
		
		if tileData:
			var isLuckyBlock = tileData.get_custom_data(isLuckyBlockData)
			var isSuperBlock = tileData.get_custom_data(isSuperBlockData)
				
			if isLuckyBlock:
				giveCoins()
			
			elif isSuperBlock:
				giftingCoins()


func digLeft():
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(-6,0)) # Offset to dig left of the player
	var tileData : TileData = tilemap.get_cell_tile_data(0, cell)

	if cell != null:
		tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
		blocksBroken += 1
		
		if tileData:
			var isLuckyBlock = tileData.get_custom_data(isLuckyBlockData)
			var isSuperBlock = tileData.get_custom_data(isSuperBlockData)
				
			if isLuckyBlock:
				giveCoins()
			
			elif isSuperBlock:
				giftingCoins()


func digRight():
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(12,0)) # Offset to dig right of the player
	var tileData : TileData = tilemap.get_cell_tile_data(0, cell)

	if cell != null:
		tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
		blocksBroken += 1
		
		if tileData:
			var isLuckyBlock = tileData.get_custom_data(isLuckyBlockData)
			var isSuperBlock = tileData.get_custom_data(isSuperBlockData)
				
			if isLuckyBlock:
				giveCoins()
			
			elif isSuperBlock:
				giftingCoins()

func digUp():
	var local_pos = tilemap.to_local(global_position)
	var cell = tilemap.local_to_map(local_pos + Vector2(0,-12)) # Offset to dig above player
	var tileData : TileData = tilemap.get_cell_tile_data(0, cell)

	if cell != null:
		tilemap.set_cell(0, cell, -1) # Layer 0, removes the tile
		blocksBroken += 1
		
		if tileData:
			var isLuckyBlock = tileData.get_custom_data(isLuckyBlockData)
			var isSuperBlock = tileData.get_custom_data(isSuperBlockData)
				
			if isLuckyBlock:
				giveCoins()
			
			elif isSuperBlock:
				giftingCoins()

func giveCoins():
	var localPos = tilemap.to_local(global_position) 
	var cell = tilemap.local_to_map(localPos) # cell of the dug tile
	
	for i in range(randomNum.randi_range(5,25)):
		var newCoin = coinsPacked.instantiate() # new coin instance
		add_child(newCoin) # add coin instance
		newCoin.global_position = tilemap.map_to_local(cell) + Vector2(randomNum.randi_range(-3,3), randomNum.randi_range(-3,3))


func giftingCoins():
	var localPos = tilemap.to_local(global_position) 
	var cell = tilemap.local_to_map(localPos) # cell of the dug tile
	
	for i in range(randomNum.randi_range(15,45)):
		var newCoin = coinsPacked.instantiate() # new coin instance
		add_child(newCoin) # add coin instance
		newCoin.global_position = tilemap.map_to_local(cell) + Vector2(randomNum.randi_range(-3,3), randomNum.randi_range(-3,3))


func _ready():
	add_to_group("players")

func _on_coin_collection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Loot"):
		gold += 1

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

func final_score():
	var playerScore = 0
	
	playerScore = (gold * 1.5) + blocksBroken
	
	print(playerScore)
