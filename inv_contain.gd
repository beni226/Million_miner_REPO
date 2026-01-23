extends GridContainer

@onready var item = preload("res://slot.tscn")
var invsize = 24
func _ready():
	#load slots in
	for i in invsize:
		var itemTemp = item.instantiate()
		add_child(itemTemp)
	#fill in items into slots	
	fillInventorySlots()
	
func fillInventorySlots():
	for i in invsize:
		get_child(i).itemName = ""
		get_child(i).itemDesc = ""
		get_child(i).itemCost = 0
		get_child(i).itemCount = 0
		get_child(i).hasItem = false
		
	for i in Global.inventory:
		get_child(i).itemName = Global.inventory[i]["name"]
		get_child(i).itemDesc = Global.inventory[i]["desc"]
		get_child(i).itemCost = Global.inventory[i]["cost"]
		get_child(i).itemCount = Global.inventory[i]["count"]
		get_child(i).get_node("Icon").play(Global.inventory[i]["name"])
		get_child(i).hasItem = true
