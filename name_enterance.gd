extends Control

@onready var submit_btn := get_node_or_null("SubmitButton")

func _ready() -> void:
	print("UI READY:", name)
	print_tree_pretty()

	if submit_btn == null:
		push_error("SubmitButton not found. Check the node path/name.")
		return

	# Works for Button + TextureButton in Godot 4
	submit_btn.pressed.connect(_on_submit_pressed)
	print("Connected pressed() for:", submit_btn.name)

func _on_submit_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	print("SUBMIT CLICKED")
