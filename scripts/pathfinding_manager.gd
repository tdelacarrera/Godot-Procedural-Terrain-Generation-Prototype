extends Node

@onready var terrain = $"../../Terrain"



var astar_grid = AStarGrid2D.new()

var path : Array

func _ready() -> void:
	init_path_finding()

func _process(delta: float) -> void:
	pass
	
func init_path_finding():
	astar_grid.region = Rect2i(0, 0, terrain.width, terrain.height)
	astar_grid.cell_size = Vector2i(128,128)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.update()
	
	for x in range(terrain.width):
		for y in range(terrain.height):
			if get_walk_cost(Vector2(x,y)) == -1:
				astar_grid.set_point_solid(Vector2(x,y))
			else:
				astar_grid.set_point_weight_scale(Vector2i(x,y),get_walk_cost(Vector2i(x,y)))

	
func find_path(start_position : Vector2i, end_position : Vector2i):
	path = astar_grid.get_point_path(start_position, end_position, false)
	return path
	
func get_walk_cost(coords : Vector2):
	return terrain.grid[coords].floor_data.walk_cost
