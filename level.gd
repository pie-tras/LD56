@tool
extends TileMapLayer

@export var map_size = 64
@export var random_fill_percent = 45
@export var smooth_steps = 5

var seed = 0
var rng = RandomNumberGenerator.new()
var map_solid = []
var map_rooms = []


func _ready() -> void:
	seed = randi()
	
	map_solid.clear()
	map_rooms.clear()
	map_solid.resize(map_size * map_size)
	map_rooms.resize(map_size * map_size)
	
	generate_map()
	
func get_tile(solid) -> Vector2i:
	if solid == 1:
		return Vector2i(1, 0)
	else:
		return Vector2i(0, 0)	

func generate_map() -> void:
	clear()
	rng.seed = hash(seed)
	
	for y in range(map_size):
		for x in range(map_size):
			var solid = 1 if random_fill_percent > rng.randi_range(0, 100) else 0
			if x == 0 or y == 0 or x == map_size - 1 or y == map_size - 1:
				solid = 1
				
			map_solid[x + y * map_size] = solid
			map_rooms[x + y * map_size] = 0
			
	for i in range(smooth_steps):
		smooth_map()
	
	for y in range(map_size):
		for x in range(map_size):
			set_cell(Vector2i(x, y), 0, get_tile(map_solid[x + y * map_size]))

func smooth_map() -> void:
	for y in range(1, map_size - 1):
		for x in range(1, map_size - 1):
			var walls = get_walls(x, y)
			
			if walls > 4:
				map_solid[x + y * map_size] = 1
			elif walls < 4:
				map_solid[x + y * map_size] = 0
			
func get_walls(x, y) -> int:
	var walls = map_solid[(x + 1) + y * map_size] + \
			 map_solid[(x - 1) + y * map_size] + \
			 map_solid[x + (y + 1) * map_size] + \
			 map_solid[x + (y - 1) * map_size] + \
			 map_solid[(x + 1) + (y + 1) * map_size] + \
			 map_solid[(x - 1) + (y + 1) * map_size] + \
			 map_solid[(x + 1) + (y - 1) * map_size] + \
			 map_solid[(x - 1) + (y - 1) * map_size]
	
	return walls
			
