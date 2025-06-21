class_name BuildingData
extends Resource

@export var name: String
@export var id: int
@export var coords: Vector2
@export var resources_required: Dictionary
@export var work_required: int
@export var is_resting_spot: bool = false
@export var is_navigable: bool = false
@export var recipes: Array[RecipeData]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
