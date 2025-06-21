extends CharacterBody2D

#var SPEED : int = 100
#var path : Array

#@onready var path_finding = $"../Managers/Pathfinding"
#@onready var terrain = $"../Terrain"
func _ready() -> void:
	pass



func _process(delta: float) -> void:
	pass
#	if Input.is_action_just_pressed("click"):
#		var current_tile_Position = self.position/terrain.tile_set.tile_size.x
#		var target_tile_position = get_global_mouse_position()/terrain.tile_set.tile_size.x
#		path = path_finding.find_path(current_tile_Position,target_tile_position)
#	if path.size() > 0:
#		var direction = position.direction_to(path[0])
#		self.velocity = direction * SPEED * 1
#		if position.distance_to(path[0]) < SPEED * delta:
#			path.remove_at(0)
#	else:
#		self.velocity = Vector2.ZERO
#	move_and_slide()
