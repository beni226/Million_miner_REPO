extends CanvasLayer
var currItem = 0
var select = 0
func _input(event):
	if event.is_action_pressed("shop"):
		get_node("Anim").play("TransIn")
func _on_close_pressed() -> void:
	get_node("Anim").play("TransOut")


func switchItem(select):
	for i in range(Global.items.size()):
		if select == i:
			currItem = select
			get_node("Control/AnimSprite").play(Global.items[currItem]["name"])
			get_node("Control/name").text = Global.items[currItem]["name"]
			get_node("Control/desc").text = Global.items[currItem]["desc"]
			get_node("Control/desc").text +="\n Cost: " + str(Global.items[currItem]["cost"])

func _on_forw_pressed() -> void:
	switchItem(currItem+1)
	
func _on_prev_pressed() -> void:
	switchItem(currItem-1)
	
func _on_button_pressed() -> void:
	var hasItem = false
	print(Global.inventory)
	if Global.gold >= Global.items[currItem]["cost"]:
		for i in Global.inventory.keys():
			if Global.inventory[i]["name"] == Global.items[currItem]["name"]:
				Global.inventory[i]["count"] += 1
				hasItem = true
				break
		if not hasItem:
			var tempDic = Global.items[currItem].duplicate()
			tempDic["count"] = 1
			var new_key: int = 0 if Global.inventory.is_empty() else Global.inventory.keys().max() + 1
			Global.inventory[new_key] = tempDic
		Global.gold -= Global.items[currItem]["cost"]
	print(Global.inventory)
	print(Global.gold)
