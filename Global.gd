extends Node

signal gold_changed(new_gold: int)

var gold: int = 10000:
	set(value):
		gold = value
		gold_changed.emit(gold)

func add_gold(amount: int) -> void:
	self.gold += amount

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
		"cost": 20
	},
	2: {
		"name":"pickaxe upgrade",
		"desc":"upgrade your pickaxe strength",
		"cost": 100   
	},
	3: {
		"name":"torch",
		"desc":"increases light in the caves",
		"cost": 35 
	},
	4: {
		"name":"lamp",
		"desc":"increases light even further",
		"cost": 100  
	},
	
}

var inventory = {
	0: {
		"name": "speed potion",
		"desc": "speed boost!!!",
		"cost": 10,
		"count": 1
	},
}	
