extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.grab_focus()
	add_theme_color_override("placeholder_color", Color(0.0, 0.0, 0.0, 1.0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
