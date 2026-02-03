extends Control

@onready var label = $Label

func _ready():
	Global.gold_changed.connect(on_gold_changed)

func on_gold_changed(new_gold):
	label.text = str(new_gold)
	
