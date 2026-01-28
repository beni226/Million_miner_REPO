extends GridContainer

@onready var item = preload("res://slot.tscn")
func _ready():
	#load slots in
	var invsize = 5
	for i in range(invsize):
		add_child(item.instantiate())
	#fill in items into slots	
		fillInventorySlots()
	
func fillInventorySlots():
	for i in range(get_child_count()):
		var slot = get_child(i)
		slot.itemName = ""
		slot.itemDesc = ""
		slot.itemCost = 0
		slot.itemCount = 0
		slot.hasItem = false
		slot.get_node("Icon").visible = false

	var slot_index = 0
	for key in Global.inventory.keys():
		if slot_index >= get_child_count():
				break
		var slot = get_child(slot_index)
		var item = Global.inventory[key]
		slot.itemName = item["name"]
		slot.itemDesc = item["desc"]
		slot.itemCost = item["cost"]
		slot.itemCount = item["count"]
		slot.hasItem = true
		slot.get_node("Icon").visible = true
		slot.get_node("Icon").play(item["name"])
		slot_index += 1
