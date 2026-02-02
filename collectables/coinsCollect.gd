extends Node

var total_coins: int = 1

func coin_collected(value: int):
	total_coins += value
	TileTest.emit_signal("coin_collected", total_coins)
