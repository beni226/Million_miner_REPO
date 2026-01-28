extends CanvasLayer
var itemName = " "
var itemDesc = " "
var itemCost = 0
var itemCount = 0
var itemAnim := ""
@onready var icon: AnimatedSprite2D = $Icon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func UpdateInfo():
	get_node("Title").text = itemName
	get_node("Des").text = itemDesc + "\n Count:" + str(itemCount)
	if itemAnim != "":
		icon.play(itemAnim)
	
	

func _on_close_pressed() -> void:
	get_node("anni").play("TransOut")
	get_node("../../").process_mode = Node.PROCESS_MODE_ALWAYS
