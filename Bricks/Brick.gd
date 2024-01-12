extends Node

var hit_points

#@onready var animated_sprite = get_node("AnimatedSprite2D")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("brick", true)
	hit_points = animated_sprite.sprite_frames.get_frame_count("default")
	
	pass # Replace with function body.

func decrease_hit_points():
	hit_points -= 1
	# redundant check
	if animated_sprite.frame < animated_sprite.sprite_frames.get_frame_count("default") - 1:
		animated_sprite.frame += 1
	
	if hit_points <= 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
