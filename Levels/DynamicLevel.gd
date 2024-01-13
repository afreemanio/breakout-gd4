extends Node2D

@export_range(1, 8) var rows = 3
@export_range(1, 10) var columns = 10
@export_range(1, 5) var difficulty = 1 
@export var testmode = false 
# brick size
const cell_width = 96
const cell_height = 32

var bricks = []


const brick_class = preload("res://Bricks/Brick.tscn")
const globalrandom = preload("res://Worlds/GlobalRandom.tres")

signal level_done


func handle_global_random():
	if globalrandom.random_mode_enabled:
		difficulty = randi_range(1, 5)

func test_one_brick():
	var brick = brick_class.instantiate()
	init_brick(brick.Frames.BLUE, brick, 0, 0)
	return

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_global_random()
	rows += difficulty
	var empty_brick_range = 0.6 - (difficulty / 10.0) # [0.1, 0.5]
	if testmode:
		test_one_brick()
		return

	
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
	print(bricks)
	pass # Replace with function body.

func init_brick(brick_frames_type, brick, row, column, indestructible = false):
	brick.set_frame_type(brick_frames_type)
	brick.set_indestructible(indestructible)
	add_child(brick)
	brick.position.x = column * cell_width
	brick.position.y = row * cell_height
	if not indestructible:
		bricks.append(brick)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_ball_brick_hit(brick):
	var brick_pos = bricks.find(brick)
	var brick_found = brick_pos != -1
	if brick_found and not brick.is_alive_after_hit():
		#print(str("brick found at index", brick_pos))
		bricks.remove_at(brick_pos)
		print(str("bricks remaining: ", len(bricks)))
	#else:
		#print("brick not found")
	#print(str("brick hit: ", brick))
	if len(bricks) == 0:
		emit_signal("level_done")
		print("level done")
	pass # Replace with function body.
