extends Node

class_name Task

enum TaskType {
	WALK_TO,
	IDLE,
	HARVEST,
	BUILD,
	EAT,
	ATTACK,
	PICKUP,
	WALK_TO_NEAREST_ITEM
}

var type : TaskType
var target_item : Item
var duration : float

func _init(type : TaskType):
	self.type = type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
