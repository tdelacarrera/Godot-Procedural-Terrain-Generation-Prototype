extends Node

@onready var path_finding_manager = $"../../Managers/PathfindingManager"
@onready var item_manager = $"../../Managers/ItemManager"
@onready var terrain = $"../../Terrain"
@onready var pawn = $".."
var task_target : Task
var tasks : Array
var path : Array
var SPEED = 100
var current_task : Task
var executing_task : bool


func _ready() -> void:
	return
	add_initial_debug_tasks()
	add_task(Task.new(Task.TaskType.IDLE))
	current_task = tasks[0]

func _process(delta: float) -> void:
	return
	if current_task != null and !executing_task:
		start_current_task(current_task)
		executing_task = true
		
	if Input.is_action_just_pressed("click"):
			add_task(Task.new(Task.TaskType.WALK_TO))
			add_initial_debug_tasks()
		
	if Input.is_action_just_pressed("ui_accept"):
			add_task(Task.new(Task.TaskType.WALK_TO_NEAREST_ITEM))
			add_initial_debug_tasks()
	update_path(delta)

func update_path(delta):
	if path.size() > 0:
		var direction = pawn.position.direction_to(path[0])
		pawn.velocity = direction * SPEED * 1
		if pawn.position.distance_to(path[0]) < SPEED * delta:
			path.remove_at(0)
	else:
		pawn.velocity = Vector2.ZERO
		on_task_finished()
	pawn.move_and_slide()
			
func on_task_finished():
	if tasks.size() > 0:
		current_task = tasks.pop_front()
	else:
		current_task = null
	executing_task = false

func add_task(new_task: Task):
	tasks.append(new_task)
	current_task = new_task
	
func request_path(has_target_item : bool):
	if has_target_item:
		var current_tile_Position = pawn.position/terrain.tile_set.tile_size.x
		var target_tile_position = item_manager.find_nearest_item_by_name(pawn.position, "apple").position/terrain.tile_set.tile_size.x
		path = path_finding_manager.find_path(current_tile_Position,target_tile_position)
	else:
		var current_tile_Position = pawn.position/terrain.tile_set.tile_size.x
		var target_tile_position = pawn.get_global_mouse_position()/terrain.tile_set.tile_size.x
		path = path_finding_manager.find_path(current_tile_Position,target_tile_position)
		

func start_current_task(current_task):
	match current_task.type:
		Task.TaskType.IDLE:
			idle()
		Task.TaskType.WALK_TO:
			request_path(false)
		Task.TaskType.WALK_TO_NEAREST_ITEM:
			request_path(true)
		Task.TaskType.EAT:
			eat()
		Task.TaskType.HARVEST:
			harvest()
		Task.TaskType.PICKUP:
			pickup()
		Task.TaskType.BUILD:
			build()
			
func add_initial_debug_tasks():
	add_task(Task.new(Task.TaskType.HARVEST))
	add_task(Task.new(Task.TaskType.BUILD))
	add_task(Task.new(Task.TaskType.PICKUP))
	add_task(Task.new(Task.TaskType.EAT))
	add_task(Task.new(Task.TaskType.PICKUP))
	add_task(Task.new(Task.TaskType.PICKUP))


func eat():
	print("eat")
	
func pickup():
	print("pickup")
	on_task_finished()

func build():
	print("build")
	on_task_finished()

func harvest():
	print("harvest")
	on_task_finished()
	
func idle():
	print("idle")
	on_task_finished()
	
