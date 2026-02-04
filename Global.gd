extends Node

signal gold_changed(new_gold: int)

func _ready() -> void:
	SilentWolf.configure({
	"api_key": "RlkfpF0dE34ukIMt29I5Z5q6OY9vAl9o4u726Nkz",
	"game_id": "MillionMiner",
	"log_level": 1
	})

	SilentWolf.configure_scores({
	"open_scene_on_close": "res://tileTest.tscn"
  	})

var gold: int = 10000:
	set(value):
		gold = value
		gold_changed.emit(gold)

func add_gold(amount: int) -> void:
	self.gold += amount
	GameState.score += 1
	print("Coins:", GameState.score)



func spend_gold(amount: int) -> bool:
	if gold >= amount:
		self.gold -= amount
		return true
	return false

var items = {
	0: {
		"name": "speed potion",
		"desc": "speed boost!!!",
		"cost": 10
	},
	1: {
		"name": "bomb",
		"desc": "destory a radius of the map!",
		"cost":50
	},
	2: {
		"name":"pickaxe upgrade",
		"desc":"upgrade your pickaxe strength",
		"cost": 25   
	},
	3: {
		"name":"lamp",
		"desc":"increases light even further",
		"cost": 30  
	},
	4: {
		"name":"double jump",
		"desc":"you can now double jump",
		"cost": 30 
	}
	
}

var inventory = {
	
}	
