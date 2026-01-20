extends Node

signal gold_changed(new_gold)

var gold := 10000

func add_gold(amount: int) -> void:
	gold += amount
	emit_signal("gold_changed", gold)

func spend_gold(amount: int) -> bool:
	if gold >= amount:
		gold -= amount
		emit_signal("gold_changed", gold)
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
		"cost": 50  
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
