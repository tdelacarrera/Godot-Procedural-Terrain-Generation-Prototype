class_name CellData
extends Object

var coords: Vector2
var floor_data: FloorData = null
var building_data: BuildingData = null
var item_data: ItemData = null
var navigable: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _init(_coords: Vector2):
	coords = _coords

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw_item():
	pass
	
