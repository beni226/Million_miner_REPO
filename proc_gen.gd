extends Node2D

@export var noise_height_text : NoiseTexture2D
var noise : Noise

var width : int = 50
var height : int = 50

var randomNum = RandomNumberGenerator.new()

@onready var tile_map = $TileMap

var source_id = 0
var question_atlas = Vector2i(0,2)
var exclamation_atlas = Vector2i(1,2)

func _ready():
	noise = noise_height_text.noise
	generate_world()
	
func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			if noise_val < 0.0:
				if randomNum.randf() < 0.024:
					#place question block
					tile_map.set_cell(0, Vector2(x,y), source_id, question_atlas)
				if randomNum.randf() < 0.008:
					#place exclamation block
					tile_map.set_cell(0, Vector2(x,y), source_id, exclamation_atlas)
