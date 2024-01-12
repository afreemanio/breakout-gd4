extends Node



#@onready var animated_sprite = get_node("AnimatedSprite2D")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

enum Frames {BLUE = 0, GREEN = 1, DARK = 2}

var hit_points
var blue_frames = preload("res://Bricks/Frames/blue_brick_frames.tres")
var green_frames = preload("res://Bricks/Frames/green_brick_frames.tres")
var dark_frames = preload("res://Bricks/Frames/dark_brick_frames.tres")
var indestructible = false

# Defaulted frames
var current_frame_type = Frames.BLUE


func set_frame_type(frames):
	current_frame_type = frames

func set_indestructible(value: bool):
	indestructible = value

# when the object initializes - this runs, setting the frames for the sprite
# then, set frames is used in the parent to set the frames
# this works because of some scene tree mumbo jumbo...
func set_animated_sprite_frames_from_current_frames():
	# Match statement is like switch statement
	match current_frame_type:
		Frames.BLUE:
			animated_sprite.frames = blue_frames
		Frames.GREEN:
			animated_sprite.frames = green_frames
		Frames.DARK:
			animated_sprite.frames = dark_frames

# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("brick", true)
	#change_frames(Frames.DARK)
	#change_frames(Frames.GREEN)
	set_animated_sprite_frames_from_current_frames()
	hit_points = animated_sprite.sprite_frames.get_frame_count("default")
	
	pass # Replace with function body.

func decrease_hit_points():
	if indestructible:
		return
	hit_points -= 1
	# redundant check
	if animated_sprite.frame < animated_sprite.sprite_frames.get_frame_count("default") - 1:
		animated_sprite.frame += 1
	
	if hit_points <= 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
