extends TileMapLayer

@onready var item_manager = $"../Managers/ItemManager"

@export var width : int
@export var height : int
@export var seed : int = 0
@export var grass_threshold : float
@export var dirt_threshold : float
@export var mountain_threshold : float
@export var cell_size : int
@export var show_debug: bool
var grid : Dictionary

func _ready() -> void:
	#generate_grid()
	generate_grid_with_noise()
	generate_mountains()

func _process(delta: float) -> void:
	debug_place_item()
	
func generate_grid():
	for x in width:
		for y in width:
			var grid_coords = Vector2(x,y)
			grid[grid_coords] = CellData.new(Vector2(x,y))
			grid[grid_coords].floor_data = preload("res://data/floor/missing.tres")
			
			refresh_cell(Vector2(x,y))
			
			if show_debug:
				var rect = ReferenceRect.new()
				rect.position = grid_to_world_coords(Vector2(x,y))
				rect.size = Vector2(cell_size,cell_size)
				rect.editor_only = false
				add_child(rect)
				var label = Label.new()
				label.position = grid_to_world_coords(Vector2(x,y))
				label.text = str(Vector2(x,y))
				add_child(label)
	print(grid[Vector2(0,1)])
	
	
func generate_grid_with_noise():
	var random = RandomNumberGenerator.new()
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	if seed == 0:
		noise.seed = random.randi()
	else:
		noise.seed = seed
		
	for x in range(width):
		for y in range(height):
			var grid_coords = Vector2(x,y)
			grid[grid_coords] = CellData.new(Vector2(x,y))
			if noise.get_noise_2d(x,y) > grass_threshold:
				grid[grid_coords].floor_data = preload("res://data/floor/grass.tres")
			elif noise.get_noise_2d(x,y) > dirt_threshold:
				grid[grid_coords].floor_data = preload("res://data/floor/dirt.tres")
			else:
				grid[grid_coords].floor_data = preload("res://data/floor/grass.tres")
			refresh_cell(Vector2(x,y))
			
func generate_mountains():
	var random = RandomNumberGenerator.new()
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	if seed == 0:
		noise.seed = random.randi()
	else:
		noise.seed = seed
	for x in range(width):
		for y in range(height):
			var grid_coords = Vector2(x,y)
			if noise.get_noise_2d(x,y) > mountain_threshold:
				if grid[grid_coords].item_data == null:
					grid[grid_coords].item_data = load("res://data/items/mountain_test.tres")
					item_manager.spawn_item(grid[grid_coords].item_data,grid_to_world_coords(grid[grid_coords].coords),cell_size)
			if random.randi_range(1,100) < 30 and grid[grid_coords].floor_data.name != "dirt":
				if grid[grid_coords].item_data == null:
					grid[grid_coords].item_data = load("res://data/items/tree.tres")
					item_manager.spawn_item(grid[grid_coords].item_data,grid_to_world_coords(grid[grid_coords].coords),cell_size)

func grid_to_world_coords(coords : Vector2i):
	return coords * cell_size
	
func world_to_grid_coords(coords : Vector2):
	return coords/cell_size

func refresh_cell(coords : Vector2):
	var cell_data = grid[coords]
	set_cell(coords, cell_data.floor_data.id, cell_data.floor_data.coords)
	if cell_data.building_data:
		set_cell(coords, cell_data.building_data.id, cell_data.building_data.coords)
		
func debug_place_item():
	if show_debug:
		if  Input.is_action_pressed("click"):
			var mouse_coords = get_global_mouse_position()
			var grid_coords = floor(world_to_grid_coords(mouse_coords))
			var debug_text = str(grid[grid_coords].floor_data.name)+" "+str(grid_coords)
			var item_name = "empty"
			if grid[grid_coords].item_data != null:
				item_name = grid[grid_coords].item_data.name
			debug_text += " "+item_name
			var label = get_node("../CanvasLayer/GUI/TerrainInfo")
			label.text = str(debug_text)
			#place item
		if  Input.is_action_pressed("ui_accept"):
			var mouse_coords = get_global_mouse_position()
			var grid_coords = floor(world_to_grid_coords(mouse_coords))
			var debug_text = str(grid[grid_coords].floor_data.name)+" "+str(grid_coords)
			if grid[grid_coords].item_data == null:
				grid[grid_coords].item_data = load("res://data/items/tree.tres")
				item_manager.spawn_item(grid[grid_coords].item_data,grid_to_world_coords(grid[grid_coords].coords),cell_size)
