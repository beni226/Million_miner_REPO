extends Node2D

@export var noise_height_text : NoiseTexture2D

var noise : Noise
var noiseThreshold : float = 0.2

# size of map, edit numbers for diff ranges, reference for where blocks spawn
# dirt blocks still need to be placed through tilemap,
# width and height need to be changed according to dirt blocks
var width : int = 200
var height : int = 200

var randomNum = RandomNumberGenerator.new()

# references the standard tile map
@onready var tile_map = $TileMap

var source_id = 0
var dirt_atlas = Vector2i(0,1) # location on tileset
var question_atlas = Vector2i(0,2)
var exclamation_atlas = Vector2i(1,2)


func _ready():
	noise = noise_height_text.noise
	noise.set_seed(randomNum.randi())
	generateWorld()
	
func generateWorld():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			
			if noise_val < noiseThreshold:
				tile_map.set_cell(0, Vector2(x,y), source_id, dirt_atlas)
			
			if noise_val < noiseThreshold:
				# places question block at a low chance
				if randomNum.randf() < 0.020:
					tile_map.set_cell(0, Vector2(x,y), source_id, question_atlas)
				
				# places exclamation block at a lower chance
				if randomNum.randf() < 0.008:
					tile_map.set_cell(0, Vector2(x,y), source_id, exclamation_atlas)
