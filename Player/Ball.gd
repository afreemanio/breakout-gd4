extends CharacterBody2D

@export var speed = 500


@onready var ball_visibility_notifier = $BallVisibilityNotifier
#@onready var ball_visibility_notifier = get_node("BallVisibilityNotifier")
@onready var audio_player = $AudioStreamPlayer

const player_container = preload("res://Player/PlayerContainer.tres")
const globalrandom = preload("res://Worlds/GlobalRandom.tres")
const audio_manager = preload("res://Audio/AudioManager.tres")
signal game_over

#velocity = Vector2(0, 0)
var world = "res://Worlds/World.tscn"
var direction = Vector2(0.5, 1)
var is_running = false

signal brick_hit(brick)

func _ready():
	handle_global_random()
	audio_manager.initialize()
	audio_manager.attach_sound(self, audio_manager.SoundType.HIT_BRICK)
	audio_manager.attach_sound(self, audio_manager.SoundType.HIT_WALL)
	audio_manager.attach_sound(self, audio_manager.SoundType.HIT_PLAYER)


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
			audio_manager.play_sound(AudioManager.SoundType.HIT_PLAYER, 0.20)
		# now we have to normalize the direction
		else:
			var hit_position = collision.get_collider().global_position - collision.get_position()
			print(hit_position)
			var normal = fix_normal(collision.get_normal(), hit_position)
			#print(collision.get_collider().get_meta_list())
			direction = direction.bounce(collision.get_normal())
			if collision.get_collider().get_meta("brick"):
				var brick = collision.get_collider()
				emit_signal("brick_hit", brick)
				brick.decrease_hit_points()
				if brick.is_indestructible():
					audio_manager.play_sound(AudioManager.SoundType.HIT_WALL, 0.1)
				else: 
					audio_manager.play_sound(AudioManager.SoundType.HIT_BRICK, 0.32)
			else:
				# wall hit
				audio_manager.play_sound(AudioManager.SoundType.HIT_WALL, 0.1)

	
	pass

# Normal calculation hack based on the hit position on the bricks
func fix_normal(normal, hit_position):
	if normal.x == 1 or normal.x == -1 or normal.y == 1 or normal.y == -1:
		return normal
	if hit_position.x < 2 and hit_position.y < 2:
		# upper left corner
		normal = Vector2(-0.5, -0.5)
	elif hit_position.x > 94 and hit_position.y < 2:
		# upper right corner
		normal = Vector2(0.5, -0.5)
	elif hit_position.x > 94 and hit_position.y > 30:
		# bottom right corner
		normal = Vector2(0.5, 0.5)
	elif hit_position.x < 2 and hit_position.y > 30:
		# bottom left corner
		normal = Vector2(-0.5, 0.5)
	
	normal = normal.normalized()
	return normal

func play_sound(audio_file_path, offset):
	var audio_player = AudioStreamPlayer.new()
	get_tree().get_root().add_child(audio_player)
	var file = load(audio_file_path)
	audio_player.set_stream(file)
	audio_player.play(offset)

func get_x_bounce_direction(collision: KinematicCollision2D):
	var relative_x = collision.get_position().x - player_container.player.global_position.x
	var percentage = relative_x / player_container.player_width
	return (percentage - 0.5) * 2 # [-1, 1]
	
	
func handle_global_random():
	if globalrandom.random_mode_enabled:
		speed = randi_range(400, 2000)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func is_game_over():
	if not ball_visibility_notifier.is_on_screen():
		emit_signal("game_over")
		is_running = false



func _on_dynamic_level_level_done():
	is_running = false
	pass # Replace with function body.
