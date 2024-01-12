extends Node2D

@export var rows = 3
@export var columns = 10
@export_range(1, 5) var difficulty = 1 
# brick size
const cell_width = 96
const cell_height = 32

const blue_brick_class = preload("res://Bricks/BlueBrick.tscn")
const green_brick_class = preload("res://Bricks/GreenBrick.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	rows += difficulty
	var empty_brick_range = 0.6 - (difficulty / 10.0) # [0.1, 0.5]
	
	for column in range(0, columns):
		for row in range(0, rows):
			var random = randf_range(0, 1)
			if random < empty_brick_range:
				pass
			elif random < 0.7:
				var blue_brick = blue_brick_class.instantiate()
				init_brick(blue_brick, row, column)
			else:
				var green_brick = green_brick_class.instantiate()
				init_brick(green_brick, row, column)
	
	pass # Replace with function body.

func init_brick(brick, row, column):
	add_child(brick)
	brick.position.x = column * cell_width
	brick.position.y = row * cell_height
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
