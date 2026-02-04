extends Control

@onready var label = $Label

func _ready():
	label.text = str(Global.gold)
	Global.gold_changed.connect(on_gold_changed)

func on_gold_changed(new_gold):
	label.text = str(new_gold)
	
