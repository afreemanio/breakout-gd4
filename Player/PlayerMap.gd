extends TileMap

@onready var area = $Area2D

func _ready():
	var layer = 0
	# layer 0 is the layer of the 2d area, this gets the used cells of it
	var cells = get_used_cells(layer)
	# https://docs.godotengine.org/en/stable/classes/class_tilemap.html
	# https://docs.godotengine.org/en/latest/classes/class_tileset.html#class-tileset-property-tile-size
	var tile_size = self.tile_set.tile_size
	
	for c in cells:
		#var data = get_cell_tile_data(layer, c)
		var data = get_cell_source_id(layer, c)
		var points = data.get_collision_polygon_points(0, layer)
		var collision_shape = CollisionPolygon2D.new()
		collision_shape.polygon = points
		#collision_shape.position = c*cell_quadrant_size + Vector2i(cell_quadrant_size, cell_quadrant_size)/2
		collision_shape.position = c*tile_size.x + tile_size/2
		area.add_child(collision_shape)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
