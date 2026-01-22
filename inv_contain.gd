extends GridContainer

@onready var item = preload("res://slot.tscn")
var invsize = 24
func _ready():
	#load slots in
	for i in invsize:
		var itemTemp = item.instantiate()
		add_child(itemTemp)
