#extends CharacterBody2D
#
#
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()


extends CharacterBody2D

@export var acceleration = 500

const player_container = preload("res://Player/PlayerContainer.tres")
const globalrandom = preload("res://Worlds/GlobalRandom.tres")


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# var velocity = Vector2.ZERO

var friction = 200
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var original_pos = 0

func handle_global_random():
	if globalrandom.random_mode_enabled:
		acceleration = randi_range(400, 1500)

func _ready():
	handle_global_random()
	print("I am ready")
	player_container.player = self
	original_pos = global_position.y
	var test = $CollisionShape2D.shape.radius
	player_container.player_width = $CollisionShape2D.shape.radius
	pass


func _physics_process(delta):

	if Input.is_action_pressed("move_left"):
		velocity.x = -acceleration
	if Input.is_action_pressed("move_right"):		
		velocity.x = acceleration
	move_and_slide()
	velocity.x = velocity.move_toward(Vector2.ZERO, friction).x
	fix_y_pos()
	pass

func fix_y_pos():
	#print(str("my pos is", position))
	#print(str("my POSY is", position.y))
	#print(str("my pglobal os is", global_position))
	position.y = original_pos
	#position.y = 749
	#set_position(Vector2(position.x, 749))
	#print(str("my pos is", position))
	#print(str("position.y", position.y))
	#if position.y != 749:
		#var test = position.y
		#print("HELP!")
	
	pass
















