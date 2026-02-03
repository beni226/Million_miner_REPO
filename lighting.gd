extends ColorRect

var lamp_enabled := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material = material.duplicate()
	show()
	# Comment and uncomment the line below to get rid of shaders
	#modulate.a = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var light_positions = _get_light_postions()
	material.set_shader_parameter("numOfLights", light_positions.size())
	material.set_shader_parameter("lights", light_positions)

	var has_lamp = has_item("lamp")
	if has_lamp != lamp_enabled:
		lamp_enabled = has_lamp
		_update_lighting()

func _update_lighting():
	if lamp_enabled:
		material.set_shader_parameter("bandRadius", 180.0)
		material.set_shader_parameter("bandStrength", 0.6)
		material.set_shader_parameter("lightRadius", 500.0)

	else:
		material.set_shader_parameter("bandRadius", 96.0)
		material.set_shader_parameter("bandStrength", 0.3)
		material.set_shader_parameter("lightRadius", 148.0)
func _get_light_postions():
	return get_tree().get_nodes_in_group("lightSources").map(
		func(light: Node2D):
			return light.get_global_transform_with_canvas().origin
	)
func has_item(item_name: String) -> bool:
	for i in Global.inventory.keys():
		if Global.inventory[i]["name"] == item_name:
			return true
	return false
