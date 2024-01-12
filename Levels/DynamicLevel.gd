extends Node2D

@export var rows = 3
@export var columns = 10
@export_range(1, 5) var difficulty = 1 
# brick size
const cell_width = 96
const cell_height = 32

const brick_class = preload("res://Bricks/Brick.tscn")
const globalrandom = preload("res://Worlds/GlobalRandom.tres")


func handle_global_random():
	if globalrandom.random_mode_enabled:
		difficulty = randi_range(1, 8)


# Called when the node enters the scene tree for the first time.
func _ready():
	handle_global_random()
	rows += difficulty
	var empty_brick_range = 0.6 - (difficulty / 10.0) # [0.1, 0.5]
	
	for column in range(0, columns):
		for row in range(0, rows):
			var random = randf_range(0, 1)
			if random < empty_brick_range:
				pass
			elif random < 0.7:
				var brick = brick_class.instantiate()
				init_brick(brick.Frames.BLUE, brick, row, column)
			elif random < 0.9:
				var brick = brick_class.instantiate()
				init_brick(brick.Frames.GREEN, brick, row, column)
			else:
				var brick = brick_class.instantiate()
				init_brick(brick.Frames.DARK, brick, row, column, true)
	
	pass # Replace with function body.

func init_brick(brick_frames_type, brick, row, column, indestructible = false):
	brick.set_frame_type(brick_frames_type)
	brick.set_indestructible(indestructible)
	add_child(brick)
	brick.position.x = column * cell_width
	brick.position.y = row * cell_height
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
