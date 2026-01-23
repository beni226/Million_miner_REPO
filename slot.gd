extends Panel
var itemName = ""
var itemDesc = ""
var itemCost = 0
var itemCount = 0
var hasItem = false
var mouseEntered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hasItem == true:
		get_node("Icon").show()
		get_node("countr").show()
	else:
		get_node("Icon").hide()
		get_node("countr").hide()

func _on_mouse_entered() -> void:
	mouseEntered = true

func _on_mouse_exited() -> void:
	mouseEntered = false
