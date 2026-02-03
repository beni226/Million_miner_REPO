extends CanvasLayer

var coinsCollected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$coincount.text = "Coins: " + str(coinsCollected)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
