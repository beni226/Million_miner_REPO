extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SilentWolf.configure({
	"api_key": "RlkfpF0dE34ukIMt29I5Z5q6OY9vAl9o4u726Nkz",
	"game_id": "MillionMiner",
	"log_level": 1
	})

	SilentWolf.configure_scores({
	"open_scene_on_close": "res://main.tscn"
  }) 
