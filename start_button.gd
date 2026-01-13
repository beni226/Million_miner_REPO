extends Button
"res://tileTest.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(on_start_pressed)
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://tileTest.tscn")
