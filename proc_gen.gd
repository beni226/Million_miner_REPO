extends Node2D

@export var noise_height_text : NoiseTexture2D
var noise : Noise

# size of map, edit numbers for diff ranges, reference for where blocks spawn
# dirt blocks still need to be placed through tilemap,
# width and height need to be changed according to dirt blocks
var width : int = 100
var height : int = 100

var randomNum = RandomNumberGenerator.new()

# references the standard tile map
@onready var tile_map = $TileMap

var source_id = 0
var question_atlas = Vector2i(0,2) # location on tileset
var exclamation_atlas = Vector2i(1,2)

func _ready():
	noise = noise_height_text.noise
	generate_world()
	
func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			
			if noise_val < 0.0:
				# places question block at a low chance
				if randomNum.randf() < 0.024:
					tile_map.set_cell(0, Vector2(x,y), source_id, question_atlas)
				
				# places exclamation block at a lower chance
				if randomNum.randf() < 0.008:
					tile_map.set_cell(0, Vector2(x,y), source_id, exclamation_atlas)
