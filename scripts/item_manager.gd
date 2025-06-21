extends Node

class_name ItemManager

@export var ItemPackedScene : PackedScene
var items_in_the_world : Array

func _ready():
	pass
	#spawn_initial_debug_items()
	
func _process(delta: float) -> void:
	pass
	
func spawn_item(item_data, coords, cell_size):
	var item_instance = ItemPackedScene.instantiate()
	item_instance.load_properties(item_data)
	item_instance.position.x = coords.x + cell_size/2
	item_instance.position.y = coords.y + cell_size/2
	items_in_the_world.append(item_instance)
	add_child(item_instance)
	

#func spawn_item(item_name: String, position : Vector2):
#	var properties_path = "res://data/items/%s.tres" % item_name
	#var properties = load(properties_path)
	
	#if properties == null:
	#	print("Error: No se pudo cargar el recurso en: %s" % properties_path)
	#	return
		
#	var item_instance = ItemPackedScene.instantiate()
	#item_instance.load_properties(properties)
	#item_instance.position = position * 128
	#items_in_the_world.append(item_instance)
	#add_child(item_instance)
	
#func spawn_initial_debug_items():
	#spawn_item("simple_prepared_food",Vector2(20,115))
	#spawn_item("apple",Vector2(10,15))
	#spawn_item("tree",Vector2(40,15))
	#spawn_item("apple",Vector2(20,15))
	#for i in items_in_the_world:
		#print(i.position)
		#print(i.properties.name)
		#print(i.properties.description)

#func find_nearest_item_by_name(current_position : Vector2, name : String) -> Item:
	#var nearest_item = null
	#var nearest_distance = 99999
	#for item in items_in_the_world:
	#	if item.properties.name == name:
			#var distance = current_position.distance_to(item.position)
			#if distance < nearest_distance:
				#nearest_distance = distance
				#nearest_item = item
	#return nearest_item 
