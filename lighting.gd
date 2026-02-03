extends ColorRect



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	
	
	
	# Comment and uncomment the line below to get rid of shaders
	#modulate.a = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var lightPositions = _get_light_postions()
	material.set_shader_parameter("numOfLights", lightPositions.size())
	material.set_shader_parameter("lights", lightPositions)

func _get_light_postions():
	return get_tree().get_nodes_in_group("lightSources").map(
		func(light: Node2D):
			return light.get_global_transform_with_canvas().origin
	)
	
