extends Sprite2D

class_name Item

var properties : Resource

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
func load_properties(properties):
	self.properties = properties
	texture = properties.texture
