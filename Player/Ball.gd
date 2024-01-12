extends CharacterBody2D

@export var speed = 500


@onready var ball_visibility_notifier = $BallVisibilityNotifier
#@onready var ball_visibility_notifier = get_node("BallVisibilityNotifier")

const player_container = preload("res://Player/PlayerContainer.tres")
const globalrandom = preload("res://Worlds/GlobalRandom.tres")

#velocity = Vector2(0, 0)
var world = "res://Worlds/World.tscn"
var direction = Vector2(0.5, 1)
var is_running = false
var game_over = false

signal brick_hit(brick)


func _physics_process(delta):

	if Input.is_action_just_pressed("fire"):
		is_running = true
	if not is_running:
		return
	is_game_over()
	
	
	# since we are using move and collide not move and slide, we need to
	# multiply by delta manually
	direction = direction.normalized()
	velocity = speed * direction * delta
	# returns a colllision
	
	var collision = move_and_collide(velocity)

	if collision != null:
		if collision.get_collider() == player_container.player:
			print(str("Collider: Player: ", collision.get_collider()))
			direction = direction.bounce(collision.get_normal())
	
			direction.x = get_x_bounce_direction(collision)
		# now we have to normalize the direction
		else:
			#print(collision.get_collider().get_meta_list())
			if collision.get_collider().get_meta("brick"):
				var brick = collision.get_collider()
				emit_signal("brick_hit", brick)
				brick.decrease_hit_points()
			direction = direction.bounce(collision.get_normal())
	
	pass

func get_x_bounce_direction(collision: KinematicCollision2D):
	var relative_x = collision.get_position().x - player_container.player.global_position.x
	var percentage = relative_x / player_container.player_width
	return (percentage - 0.5) * 2 # [-1, 1]
	
	
func handle_global_random():
	if globalrandom.random_mode_enabled:
		speed = randi_range(400, 2000)


func _ready():
	handle_global_random()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func is_game_over():
	if not game_over and not ball_visibility_notifier.is_on_screen():
		print("Game over")
		game_over = true
		#get_tree().change_scene(world)
		get_tree().change_scene_to_file(world)



