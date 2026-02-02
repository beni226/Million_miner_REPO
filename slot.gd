extends Panel
var itemName = ""
var itemDesc = ""
var itemCost = 0
var itemCount = 0
var hasItem = false
#var mouseEntered = false

@onready var item_info = get_node("../../ItemInfo")
@onready var item_anim = item_info.get_node("anni")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
		

'''func _on_mouse_entered() -> void:
	if hasItem == true:
		mouseEntered = true
		#get_node("countr").show()

func _on_mouse_exited() -> void:
	mouseEntered = false
	#get_node("countr").hide()
	'''
func _gui_input(event: InputEvent) -> void:
	if not hasItem:
		return

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			item_info.itemAnim = itemName
			item_info.itemName = itemName
			item_info.itemDesc = itemDesc
			item_info.itemCost = itemCost
			item_info.itemCount = itemCount
			item_anim.play("TransIn")
			item_info.UpdateInfo()
func update_icon_visibility():
	get_node("Icon").visible = hasItem

			
