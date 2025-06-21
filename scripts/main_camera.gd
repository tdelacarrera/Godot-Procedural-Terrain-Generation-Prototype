extends Camera2D

@export var move_speed: float
@export var zoom_speed : float

var drag_start_mouse_pos = Vector2.ZERO
var drag_start_camera_pos = Vector2.ZERO
var zoom_target : Vector2
var is_dragging : bool

func _ready() -> void:
	zoom_target = self.zoom

func _process(delta: float) -> void:
	change_zoom(delta)
	move_pan(delta)
	click_and_drag()

func change_zoom(delta: float):
	if Input.is_action_just_pressed("camera_move_in"):
		zoom_target *= 1.1
	if Input.is_action_just_pressed("camera_move_out"):
		zoom_target *= 0.9	
	
	self.zoom = self.zoom.lerp(zoom_target, zoom_speed * delta)

func move_pan(delta: float):
	var move_direction = Vector2.ZERO
	if Input.is_action_pressed("camera_move_right"):
		move_direction.x -= 1
	if Input.is_action_pressed("camera_move_left"):
		move_direction.x += 1
	if Input.is_action_pressed("camera_move_up"):
		move_direction.y -= 1
	if Input.is_action_pressed("camera_move_down"):
		move_direction.y += 1
	
	self.position += move_direction.normalized() * delta * move_speed * 1/zoom.x
		
func click_and_drag():
	if !is_dragging and Input.is_action_just_pressed("camera_move_pan"):
		drag_start_mouse_pos = get_viewport().get_mouse_position()
		drag_start_camera_pos = position
		is_dragging = true
		
	if is_dragging and Input.is_action_just_released("camera_move_pan"):
		is_dragging = false
	
	if is_dragging:
		var move_vector = get_viewport().get_mouse_position() - drag_start_mouse_pos
		position = drag_start_camera_pos - move_vector * 1/zoom.x
		
